import 'package:meta/meta.dart';

abstract class Attachable<T> {
  @mustCallSuper
  void detach();

  @mustCallSuper
  void attachTo(T owner);
}