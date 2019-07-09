import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> logDeckCreate() =>
    FirebaseAnalytics().logEvent(name: 'deck_create');

Future<void> logDeckDelete(String deckId) =>
    FirebaseAnalytics().logEvent(name: 'deck_delete', parameters: {
      'item_id': deckId,
    });

Future<void> logStartLearning(String deckId) =>
    FirebaseAnalytics().logEvent(name: 'deck_learning_start', parameters: {
      'item_id': deckId,
    });

Future<void> logShare(String deckId) => FirebaseAnalytics()
    .logShare(contentType: 'application/flashcards-deck', itemId: deckId);

Future<void> logCardCreate(String deckId) =>
    FirebaseAnalytics().logEvent(name: 'card_create', parameters: {
      'item_id': deckId,
    });

Future<void> logPromoteAnonymous() =>
    FirebaseAnalytics().logEvent(name: 'promote_anonymous');

Future<void> logPromoteAnonymousFail() =>
    FirebaseAnalytics().logEvent(name: 'promote_anonymous_fail');

Future<void> logAddFrontImage() =>
    FirebaseAnalytics().logEvent(name: 'add_front_image');

Future<void> logAddBackImage() =>
    FirebaseAnalytics().logEvent(name: 'add_back_image');
