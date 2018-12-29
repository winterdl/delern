import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../flutter/localization.dart';
import '../../flutter/styles.dart';
import '../../flutter/user_messages.dart';
import '../../models/deck.dart';
import '../../models/deck_access.dart';
import '../../remote/user_lookup.dart';
import '../../view_models/deck_access_view_model.dart';
import '../../views/helpers/slow_operation_widget.dart';
import '../helpers/empty_list_message.dart';
import '../helpers/helper_progress_indicator.dart';
import '../helpers/observing_animated_list.dart';
import '../helpers/save_updates_dialog.dart';
import '../helpers/send_invite.dart';
import 'deck_access_dropdown.dart';

class DeckSharingPage extends StatefulWidget {
  final DeckModel _deck;

  const DeckSharingPage(this._deck);

  @override
  State<StatefulWidget> createState() => _DeckSharingState();
}

class _DeckSharingState extends State<DeckSharingPage> {
  final TextEditingController _textController = TextEditingController();
  AccessType _accessValue = AccessType.write;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget._deck.name),
          actions: <Widget>[
            Builder(
              builder: (context) => SlowOperationWidget(
                    (cb) => IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _isEmailCorrect()
                            ? cb(() => _shareDeck(_accessValue, context))
                            : null),
                  ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).peopleLabel,
                    style: AppStyles.secondaryText,
                  ),
                ],
              ),
            ),
            _sharingEmail(),
            Expanded(child: DeckUsersWidget(widget._deck)),
          ],
        ),
      );

  Widget _sharingEmail() => ListTile(
        title: TextField(
          controller: _textController,
          onChanged: (text) {
            setState(() {});
          },
          style: AppStyles.primaryText,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).emailAddressHint,
          ),
        ),
        trailing: DeckAccessDropdown(
          value: _accessValue,
          filter: (access) => access != AccessType.owner && access != null,
          valueChanged: (access) => setState(() {
                _accessValue = access;
              }),
        ),
      );

  bool _isEmailCorrect() => _textController.text.contains('@');

  Future<void> _shareDeck(AccessType deckAccess, BuildContext context) async {
    print('Share deck: $deckAccess: ${_textController.text}');
    try {
      var uid = await userLookup(_textController.text.toString());
      if (uid == null) {
        if (await _inviteUser()) {
          setState(_textController.clear);
        }
        // Do not clear the field if user didn't send an invite.
        // Maybe user made a typo in email address and needs to correct it.
      } else {
        await DeckAccessesViewModel.shareDeck(DeckAccessModel(
            deck: widget._deck,
            uid: uid,
            access: deckAccess,
            email: _textController.text.toString()));
      }
    } on SocketException catch (_) {
      UserMessages.showMessage(Scaffold.of(context),
          AppLocalizations.of(context).offlineUserMessage);
    } on HttpException catch (e, stackTrace) {
      UserMessages.reportError(e, stackTrace);
      UserMessages.showMessage(Scaffold.of(context),
          AppLocalizations.of(context).serverUnavailableUserMessage);
    } catch (e, stackTrace) {
      UserMessages.showError(() => Scaffold.of(context), e, stackTrace);
    }
  }

  Future<bool> _inviteUser() async {
    var locale = AppLocalizations.of(context);
    var inviteUser = await showSaveUpdatesDialog(
        context: context,
        changesQuestion: locale.appNotInstalledSharingDeck,
        yesAnswer: locale.send,
        noAnswer: MaterialLocalizations.of(context).cancelButtonLabel);
    if (inviteUser) {
      await sendInvite(context);
      return true;
    }
    return false;
  }
}

class DeckUsersWidget extends StatefulWidget {
  final DeckModel _deck;

  const DeckUsersWidget(this._deck);

  @override
  State<StatefulWidget> createState() => _DeckUsersState();
}

class _DeckUsersState extends State<DeckUsersWidget> {
  DeckAccessesViewModel _deckAccessesViewModel;

  @override
  void initState() {
    _deckAccessesViewModel = DeckAccessesViewModel(widget._deck);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).whoHasAccessLabel,
                  style: AppStyles.secondaryText,
                ),
              ],
            ),
          ),
          Expanded(
            child: ObservingAnimatedList(
              list: _deckAccessesViewModel.list,
              itemBuilder: (context, item, animation, index) => SizeTransition(
                    child: _buildUserAccessInfo(item),
                    sizeFactor: animation,
                  ),
              emptyMessageBuilder: () => EmptyListMessage(
                  AppLocalizations.of(context).emptyUserSharingList),
            ),
          ),
        ],
      );

  Widget _buildUserAccessInfo(DeckAccessModel accessViewModel) {
    Function filter;
    if (accessViewModel.access == AccessType.owner) {
      filter = (access) => access == AccessType.owner;
    } else {
      filter = (access) => access != AccessType.owner;
    }

    final displayName = accessViewModel.displayName ?? accessViewModel.email;

    return ListTile(
      leading: (accessViewModel.photoUrl == null)
          ? null
          : CircleAvatar(
              backgroundImage: NetworkImage(accessViewModel.photoUrl),
            ),
      title: displayName == null
          ? HelperProgressIndicator()
          : Text(
              displayName,
              style: AppStyles.primaryText,
            ),
      trailing: DeckAccessDropdown(
        value: accessViewModel.access,
        filter: filter,
        valueChanged: (access) => setState(() {
              DeckAccessesViewModel.shareDeck(DeckAccessModel(
                  deck: _deckAccessesViewModel.deck,
                  uid: accessViewModel.uid,
                  email: accessViewModel.email,
                  access: access));
            }),
      ),
    );
  }
}
