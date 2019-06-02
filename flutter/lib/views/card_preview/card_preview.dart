import 'package:delern_flutter/flutter/localization.dart' as localizations;
import 'package:delern_flutter/models/card_model.dart';
import 'package:delern_flutter/models/deck_model.dart';
import 'package:delern_flutter/view_models/card_preview_bloc.dart';
import 'package:delern_flutter/views/base/screen_bloc_view.dart';
import 'package:delern_flutter/views/card_create_update/card_create_update.dart';
import 'package:delern_flutter/views/helpers/card_background_specifier.dart';
import 'package:delern_flutter/views/helpers/card_display_widget.dart';
import 'package:delern_flutter/views/helpers/save_updates_dialog.dart';
import 'package:delern_flutter/views/helpers/sign_in_widget.dart';
import 'package:flutter/material.dart';

class CardPreview extends StatefulWidget {
  final CardModel card;
  final DeckModel deck;

  const CardPreview({@required this.card, @required this.deck})
      : assert(card != null),
        assert(deck != null);

  @override
  State<StatefulWidget> createState() => _CardPreviewState();
}

class _CardPreviewState extends State<CardPreview> {
  CardPreviewBloc _bloc;

  @override
  void initState() {
    super.initState();
    // TODO(dotdoom): replace with a simple assignment.
    _bloc = CardPreviewBloc(card: widget.card, deck: widget.deck);
    _bloc.doShowDeleteDialog.listen(_showDeleteCardDialog);
    _bloc.doEditCard.listen((_) => _editCard());
  }

  @override
  void didChangeDependencies() {
    // TODO(ksheremet): Locale must be somewhere in ScreenBlocView
    final locale = localizations.of(context);
    if (_bloc?.locale != locale) {
      _bloc.onLocale.add(locale);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => ScreenBlocView(
        appBar: AppBar(
          title: StreamBuilder<String>(
              initialData: widget.deck.name,
              stream: _bloc.doDeckNameChanged,
              builder: (context, snapshot) => Text(snapshot.data)),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  _bloc.onDeleteDeckIntention.add(null);
                }),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: StreamBuilder<CardViewModel>(
                    stream: _bloc.cardStream,
                    initialData: _bloc.cardValue,
                    builder: (context, snapshot) => CardDisplayWidget(
                          front: snapshot.requireData.card.front,
                          back: snapshot.requireData.card.back,
                          showBack: true,
                          backgroundColor: specifyCardBackground(
                              snapshot.requireData.deck.type,
                              snapshot.requireData.card.back),
                          isMarkdown: snapshot.requireData.deck.markdown,
                          frontImages: snapshot.requireData.card.frontImagesUri,
                          backImages: snapshot.requireData.card.backImagesUri,
                        ))),
            const Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bloc.onEditCardIntention.add(null);
          },
          child: const Icon(Icons.edit),
        ),
        bloc: _bloc,
      );

  Future<void> _showDeleteCardDialog(deleteCardQuestion) async {
    final deleteCardDialog = await showSaveUpdatesDialog(
        context: context,
        changesQuestion: deleteCardQuestion,
        yesAnswer: localizations.of(context).delete,
        noAnswer: MaterialLocalizations.of(context).cancelButtonLabel);
    if (deleteCardDialog) {
      _bloc.onDeleteCard.add(CurrentUserWidget.of(context).user.uid);
    }
  }

  void _editCard() {
    Navigator.push(
        context,
        MaterialPageRoute(
            // 'name' is used by Firebase Analytics to log events.
            // TODO(dotdoom): consider better route names.
            settings: const RouteSettings(name: '/cards/edit'),
            builder: (context) =>
                CardCreateUpdate(card: widget.card, deck: widget.deck)));
  }
}
