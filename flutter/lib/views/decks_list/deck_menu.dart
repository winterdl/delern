import 'package:delern_flutter/flutter/localization.dart' as localizations;
import 'package:delern_flutter/flutter/styles.dart' as app_styles;
import 'package:delern_flutter/flutter/user_messages.dart';
import 'package:delern_flutter/models/card_model.dart';
import 'package:delern_flutter/models/deck_access_model.dart';
import 'package:delern_flutter/models/deck_model.dart';
import 'package:delern_flutter/remote/analytics.dart';
import 'package:delern_flutter/views/card_create_update/card_create_update.dart';
import 'package:delern_flutter/views/deck_sharing/deck_sharing.dart';
import 'package:delern_flutter/views/edit/edit_screen.dart';
import 'package:delern_flutter/views/helpers/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

const double _kMenuExpandedSize = 225;
const _kAnimationDuration = Duration(milliseconds: 250);

class DeckMenu extends StatefulWidget {
  final DeckModel deck;
  final double buttonSize;

  const DeckMenu({@required this.deck, @required this.buttonSize})
      : assert(deck != null),
        assert(buttonSize != null);

  @override
  State<StatefulWidget> createState() => _DeckMenuState();
}

class _DeckMenuState extends State<DeckMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: _kAnimationDuration);
  }

  @override
  Widget build(BuildContext context) => IconButton(
        padding: const EdgeInsets.all(app_styles.kIconDeckPadding),
        iconSize: widget.buttonSize,
        color: app_styles.kIconColor,
        icon: Icon(Icons.more_vert),
        onPressed: () async {
          final menuItemType = await Navigator.push(
              context,
              _MenuRoute<_DeckMenuItemType>(
                parent: context,
                controller: _controller,
              ));
          if (menuItemType != null) {
            _onDeckMenuItemSelected(context, menuItemType);
          }
        },
      );

  void _onDeckMenuItemSelected(BuildContext context, _DeckMenuItemType item) {
    // Not allow to add/edit or delete cards with read access
    // If some error occurred and it is null access
    // we still give a try to edit for a user. If user
    // doesn't have permissions they will see "Permission
    // denied".
    final allowEdit = widget.deck.access != AccessType.read;
    switch (item) {
      case _DeckMenuItemType.add:
        if (allowEdit) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: '/cards/new'),
                  builder: (context) => CardCreateUpdate(
                        card: CardModel(deckKey: widget.deck.key),
                        deck: widget.deck,
                      )));
        } else {
          UserMessages.showMessage(Scaffold.of(context),
              localizations.of(context).noAddingWithReadAccessUserMessage);
        }
        break;
      case _DeckMenuItemType.edit:
        unawaited(logDeckEditMenu(widget.deck.key));
        Navigator.push(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: '/decks/view'),
              builder: (context) => EditScreen(
                    deck: widget.deck,
                  )),
        );
        break;
      case _DeckMenuItemType.share:
        if (widget.deck.access == AccessType.owner) {
          Navigator.push(
            context,
            MaterialPageRoute(
                settings: const RouteSettings(name: '/decks/share'),
                builder: (context) => DeckSharing(widget.deck)),
          );
        } else {
          UserMessages.showMessage(Scaffold.of(context),
              localizations.of(context).noSharingAccessUserMessage);
        }
        break;
    }
  }
}

enum _DeckMenuItemType { add, edit, share }

Map<_DeckMenuItemType, String> _buildMenu(BuildContext context) {
  final deckMenu = <_DeckMenuItemType, String>{
    _DeckMenuItemType.add: localizations.of(context).addCardsDeckMenu,
    _DeckMenuItemType.edit: localizations.of(context).editCardsDeckMenu,
  };

  if (!CurrentUserWidget.of(context).user.isAnonymous) {
    deckMenu[_DeckMenuItemType.share] = localizations.of(context).shareDeckMenu;
  }
  return deckMenu;
}

class _MenuRoute<_DeckMenuItemType> extends PopupRoute<_DeckMenuItemType> {
  // We need parent to count position of menu.
  final BuildContext parent;

  final AnimationController controller;

  _MenuRoute({@required this.parent, @required this.controller})
      : assert(parent != null);

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  void didComplete(_DeckMenuItemType result) {
    controller.reverse();
    super.didComplete(result);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final RenderBox renderBox = parent.findRenderObject();
    final offset = renderBox.localToGlobal(Offset.zero);
    final rightOffset = renderBox.size.width * 3 / 4;
    final topOffset =
        (MediaQuery.of(context).size.height > (_kMenuExpandedSize + offset.dy))
            ? offset.dy
            : MediaQuery.of(context).size.height - _kMenuExpandedSize - 8;

    return Stack(children: <Widget>[
      Positioned(
        right: rightOffset,
        top: topOffset,
        height: _kMenuExpandedSize,
        child: _MenuItemsWidget(controller: controller),
      )
    ]);
  }

  @override
  Duration get transitionDuration => _kAnimationDuration;
}

class _MenuItemsWidget extends StatefulWidget {
  final AnimationController controller;

  const _MenuItemsWidget({@required this.controller});

  @override
  State<StatefulWidget> createState() => _MenuItemsWidgetState();
}

class _MenuItemsWidgetState extends State<_MenuItemsWidget>
    with SingleTickerProviderStateMixin {
  Animation<Alignment> _moveAnimation;
  Animation<double> _opacityAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    final anim = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _moveAnimation = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.bottomRight)
        .animate(anim);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(anim);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final menu = _buildMenu(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Stack(
        alignment: AlignmentDirectional.topEnd,
        children: menu.entries
            .map((entry) => FadeTransition(
                  opacity: _opacityAnimation,
                  child: Align(
                      alignment: _moveAnimation.value,
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom:
                                  (menu.length - 1 - entry.key.index) * 45.0),
                          child: _buildMenuItem(entry.key, entry.value))),
                ))
            .toList(),
      ),
    );
  }

  void finishAnimation() {
    _controller.reverse();
  }

  Widget _buildMenuItem(_DeckMenuItemType menuType, String menuItemName) =>
      RaisedButton(
        color: app_styles.menuItemBackgroundColor,
        padding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: () {
          Navigator.pop(context, menuType);
        },
        child: Text(
          menuItemName,
          style: app_styles.menuItemText,
        ),
      );
}
