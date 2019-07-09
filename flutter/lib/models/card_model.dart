import 'dart:async';
import 'dart:core';

import 'package:delern_flutter/models/base/database_observable_list.dart';
import 'package:delern_flutter/models/base/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

class CardModel implements Model {
  String deckKey;
  String key;
  String front;
  String back;
  DateTime createdAt;
  List<String> frontImagesUri = [];
  List<String> backImagesUri = [];

  CardModel({@required this.deckKey}) : assert(deckKey != null);

  // We expect this to be called often and optimize for performance.
  CardModel.copyFrom(CardModel other)
      : deckKey = other.deckKey,
        key = other.key,
        front = other.front,
        back = other.back,
        createdAt = other.createdAt;

  CardModel._fromSnapshot({
    @required this.deckKey,
    @required this.key,
    @required Map value,
  }) {
    if (value == null) {
      key = null;
      return;
    }
    front = value['front'];
    back = value['back'];
    createdAt = value['createdAt'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(value['createdAt']);
    frontImagesUri = value[frontImagesUri];
    backImagesUri = value[backImagesUri];
  }

  void addFrontImageUrl(String url) {
    frontImagesUri.add(url);
  }

  void addBackImageUrl(String url) {
    backImagesUri.add(url);
  }

  @override
  String get rootPath => 'cards/$deckKey';

  @override
  Map<String, dynamic> toMap({@required bool isNew}) {
    final path = '$rootPath/$key';
    final map = <String, dynamic>{
      '$path/front': front,
      '$path/back': back,
      '$path/frontImagesUri': frontImagesUri.toList(),
      '$path/backImagesUri': backImagesUri.toList(),
    };
    if (isNew) {
      // Important note: we ask server to fill in the timestamp, but we do not
      // update it in our object immediately. Something trivial like
      // 'await get(...).first' would work most of the time. But when offline,
      // Firebase "lies" to the application, replacing ServerValue.TIMESTAMP
      // with phone's time, although later it saves to the server correctly.
      // For this reason, we should never *update* createdAt because we risk
      // changing it (see the note above), in which case Firebase Database will
      // reject the update.
      map['$path/createdAt'] = ServerValue.timestamp;
    }
    return map;
  }

  static Stream<CardModel> get(
          {@required String deckKey, @required String key}) =>
      FirebaseDatabase.instance
          .reference()
          .child('cards')
          .child(deckKey)
          .child(key)
          .onValue
          .map((evt) => CardModel._fromSnapshot(
              deckKey: deckKey, key: key, value: evt.snapshot.value));

  static DatabaseObservableList<CardModel> getList(
          {@required String deckKey}) =>
      DatabaseObservableList(
          query: FirebaseDatabase.instance
              .reference()
              .child('cards')
              .child(deckKey)
              .orderByKey(),
          snapshotParser: (key, value) => CardModel._fromSnapshot(
                deckKey: deckKey,
                key: key,
                value: value,
              ));
}
