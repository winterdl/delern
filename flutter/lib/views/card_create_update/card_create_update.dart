import 'dart:io';

import 'package:delern_flutter/flutter/localization.dart' as localizations;
import 'package:delern_flutter/flutter/styles.dart' as app_styles;
import 'package:delern_flutter/models/card_model.dart';
import 'package:delern_flutter/models/deck_model.dart';
import 'package:delern_flutter/view_models/card_create_update_bloc.dart';
import 'package:delern_flutter/views/base/screen_bloc_view.dart';
import 'package:delern_flutter/views/helpers/save_updates_dialog.dart';
import 'package:delern_flutter/views/helpers/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

// Callback that called when image was selected
typedef ImageSelected = void Function(File file);

class CardCreateUpdate extends StatefulWidget {
  final CardModel card;
  final DeckModel deck;

  const CardCreateUpdate({@required this.card, @required this.deck})
      : assert(card != null),
        assert(deck != null);

  @override
  State<StatefulWidget> createState() => _CardCreateUpdateState();
}

class _CardCreateUpdateState extends State<CardCreateUpdate> {
  bool _addReversedCard = false;
  bool _isChanged = false;
  final TextEditingController _frontTextController = TextEditingController();
  final TextEditingController _backTextController = TextEditingController();
  final FocusNode _frontSideFocus = FocusNode();
  CardCreateUpdateBloc _bloc;

  @override
  void initState() {
    _bloc = CardCreateUpdateBloc(cardModel: widget.card);
    _bloc.doClearInputFields.listen((_) => _clearInputFields());
    _bloc.doShowConfirmationDialog.listen((_) => showCardSaveUpdateDialog());
    _frontTextController.text = widget.card.front;
    _backTextController.text = widget.card.back;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final locale = localizations.of(context);
    if (_bloc.locale != locale) {
      _bloc.onLocale.add(locale);
    }
    final uid = CurrentUserWidget.of(context).user.uid;
    if (_bloc.uid != uid) {
      _bloc.onUid.add(uid);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _frontSideFocus.dispose();
    _bloc?.dispose();
    super.dispose();
  }

  Future<void> showCardSaveUpdateDialog() async {
    if (_isChanged) {
      final locale = localizations.of(context);
      final continueEditingDialog = await showSaveUpdatesDialog(
          context: context,
          changesQuestion: locale.continueEditingQuestion,
          yesAnswer: locale.yes,
          noAnswer: locale.discard);
      if (continueEditingDialog) {
        return false;
      }
    }
    _bloc.onDiscardChanges.add(null);
  }

  @override
  Widget build(BuildContext context) => ScreenBlocView(
        appBar: _buildAppBar(),
        body: _buildUserInput(),
        bloc: _bloc,
      );

  AppBar _buildAppBar() => AppBar(
        title: Text(widget.deck.name),
        actions: <Widget>[
          StreamBuilder<bool>(
            initialData: false,
            stream: _bloc.isOperationEnabled,
            builder: (context, snapshot) => _bloc.isAddOperation
                ? IconButton(
                    tooltip: localizations.of(context).addCardTooltip,
                    icon: const Icon(Icons.check),
                    onPressed: snapshot.data ? _saveCard : null,
                  )
                : FlatButton(
                    onPressed: _isChanged && snapshot.data ? _saveCard : null,
                    child: Text(
                      localizations.of(context).save.toUpperCase(),
                      style: _isChanged && snapshot.data
                          ? const TextStyle(color: Colors.white)
                          : null,
                    ),
                  ),
          )
        ],
      );

  void _saveCard() {
    _bloc.onSaveCard.add(null);
  }

  Widget _buildImageMenuItem(IconData icon, String text) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            semanticLabel: text,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(text),
          ),
        ],
      );

  Map<_ImageMenuItemSource, Widget> _buildImageMenu(BuildContext context) {
    final imageMenu = <_ImageMenuItemSource, Widget>{}
      ..[_ImageMenuItemSource.gallery] = _buildImageMenuItem(
          Icons.add_photo_alternate,
          localizations.of(context).imageFromGalleryLabel)
      ..[_ImageMenuItemSource.photo] = _buildImageMenuItem(
          Icons.add_a_photo, localizations.of(context).imageFromPhotoLabel);
    return imageMenu;
  }

  Widget _buildImageMenuButton(ImageSelected fn) =>
      PopupMenuButton<_ImageMenuItemSource>(
        icon: Icon(
          Icons.attachment,
          semanticLabel: localizations.of(context).accessibilityAddImageLabel,
        ),
        onSelected: (source) async {
          final file = await _openImage(source);
          if (file != null) {
            fn(file);
          }
        },
        itemBuilder: (context) => _buildImageMenu(context)
            .entries
            .map((entry) => PopupMenuItem<_ImageMenuItemSource>(
                  value: entry.key,
                  child: entry.value,
                ))
            .toList(),
      );

  // TODO(ksheremet): If user didn't allow to user camera, ask again
  //                  when user opens again
  // TODO(ksheremet): Check whether camera is installed
  Future<File> _openImage(_ImageMenuItemSource imageSource) async {
    File image;
    switch (imageSource) {
      case _ImageMenuItemSource.gallery:
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
      case _ImageMenuItemSource.photo:
        image = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
    }
    return image;
  }

  Widget _buildImagesList(List<String> images, Sink<int> onDelete) {
    final widgetsList = <Widget>[];
    for (var i = 0; i < images.length; i++) {
      final imageUrl = images[i];
      widgetsList.add(
        Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(child: const CircularProgressIndicator()),
              ),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageUrl,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onDelete.add(i);
                        }),
                  ),
                ),
              ),
            ])),
      );
    }
    return Column(children: widgetsList);
  }

  // TODO(ksheremet): Refactor
  Widget _buildUserInput() {
    final frontWidgetsInput = <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              // TODO(ksheremet): limit lines in TextField
              key: const Key('frontCardInput'),
              autofocus: true,
              focusNode: _frontSideFocus,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _frontTextController,
              onChanged: (text) {
                setState(() {
                  _bloc.onFrontSideText.add(text);
                  _isChanged = true;
                });
              },
              style: app_styles.primaryText,
              decoration: InputDecoration(
                  hintText: localizations.of(context).frontSideHint),
            ),
          ),
          _buildImageMenuButton((file) {
            _bloc.onFrontImageAdded.add(file);
          }),
        ],
      ),
    ];

    final backWidgetsInput = <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              key: const Key('backCardInput'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _backTextController,
              onChanged: (text) {
                setState(() {
                  _bloc.onBackSideText.add(text);
                  _isChanged = true;
                });
              },
              style: app_styles.primaryText,
              decoration: InputDecoration(
                hintText: localizations.of(context).backSideHint,
              ),
            ),
          ),
          _buildImageMenuButton((file) {
            _bloc.onBackImageAdded.add(file);
          }),
        ],
      ),
    ];

    final widgetsList = <Widget>[]
      ..addAll(frontWidgetsInput)
      ..add(StreamBuilder<List<String>>(
        stream: _bloc.doFrontImageAdded,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            return _buildImagesList(snapshot.data, _bloc.onFrontImageDeleted);
          } else {
            return Container(height: 0, width: 0);
          }
        },
      ))
      ..addAll(backWidgetsInput)
      ..add(StreamBuilder<List<String>>(
        stream: _bloc.doBackImageAdded,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            return _buildImagesList(snapshot.data, _bloc.onBackImageDeleted);
          } else {
            return Container(height: 0, width: 0);
          }
        },
      ));

    // Add reversed card widget it it is adding cards
    if (_bloc.isAddOperation) {
      // https://github.com/flutter/flutter/issues/254 suggests using
      // CheckboxListTile to have a clickable checkbox label.
      widgetsList.add(CheckboxListTile(
        title: Text(
          localizations.of(context).reversedCardLabel,
          style: app_styles.secondaryText,
        ),
        value: _addReversedCard,
        onChanged: (newValue) {
          _bloc.onAddReversedCard.add(newValue);
          setState(() {
            _addReversedCard = newValue;
          });
        },
        // Position checkbox before the text.
        controlAffinity: ListTileControlAffinity.leading,
      ));
    }

    return ListView(
      padding: const EdgeInsets.only(left: 8, right: 8),
      children: widgetsList,
    );
  }

  void _clearInputFields() {
    setState(() {
      _isChanged = false;
      _frontTextController.clear();
      _backTextController.clear();
      _bloc.onFrontSideText.add('');
      _bloc.onBackSideText.add('');
      FocusScope.of(context).requestFocus(_frontSideFocus);
    });
  }
}

enum _ImageMenuItemSource { gallery, photo }
