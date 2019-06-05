import 'dart:async';

import 'package:delern_flutter/models/base/stream_muxer.dart';
import 'package:delern_flutter/models/base/transaction.dart';
import 'package:delern_flutter/models/card_model.dart';
import 'package:delern_flutter/models/deck_model.dart';
import 'package:delern_flutter/models/scheduled_card_model.dart';
import 'package:delern_flutter/remote/analytics.dart';
import 'package:delern_flutter/remote/error_reporting.dart' as error_reporting;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

enum LearningUpdateType {
  deckUpdate,
  scheduledCardUpdate,
}

class LearningViewModel {
  ScheduledCardModel get scheduledCard => _scheduledCard;
  ScheduledCardModel _scheduledCard;

  CardModel get card => _card;
  CardModel _card;

  DeckModel get deck => _deck;
  DeckModel _deck;

  LearningViewModel({@required DeckModel deck})
      : assert(deck != null),
        _deck = deck;

  Stream<LearningUpdateType> get updates {
    logStartLearning(deck.key);
    return StreamMuxer({
      LearningUpdateType.deckUpdate:
          DeckModel.get(key: deck.key, uid: deck.uid).map((d) => _deck = d),
      LearningUpdateType.scheduledCardUpdate:
          ScheduledCardModel.next(deck).map((casc) {
        _card = casc.card;
        _scheduledCard = casc.scheduledCard;
      }),
      // We deliberately do not subscribe to Card updates (i.e. we only watch
      // ScheduledCard). If the card that the user is looking at right now is
      // updated live, it can result in bad user experience.
    }).map((muxerEvent) => muxerEvent.key);
  }

  Future<void> answer(
      {@required bool knows, @required bool learnBeyondHorizon}) {
    final cv = _scheduledCard.answer(
        knows: knows, learnBeyondHorizon: learnBeyondHorizon);
    return (Transaction()..save(_scheduledCard)..save(cv)).commit();
  }

  // TODO(dotdoom): Code is repeated in card preview. Consider better
  // solution. Code is repeated in card preview
  Future<void> deleteCard() {
    final images = <String>[];
    if (card.frontImagesUri != null && card.frontImagesUri.isNotEmpty) {
      images.addAll(card.frontImagesUri);
    }
    if (card.backImagesUri != null && card.backImagesUri.isNotEmpty) {
      images.addAll(card.backImagesUri);
    }
    images.forEach((url) async => _deleteImage(url));

    return (Transaction()..delete(card)..delete(_scheduledCard)).commit();
  }

  // TODO(ksheremet): Consider better solution because code is repeated in card
  // preview.
  Future<bool> _deleteImage(String url) async {
    try {
      await (await FirebaseStorage.instance.getReferenceFromUrl(url)).delete();
      return true;
    } catch (e, stackTrace) {
      unawaited(
          error_reporting.report('Delete image from Storage', e, stackTrace));
      // TODO(ksheremet): Notify user that error occured when deleting card
      return false;
    }
  }
}
