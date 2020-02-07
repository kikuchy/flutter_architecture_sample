import 'package:flutter/foundation.dart';

typedef ErrorMessageCallback = void Function(String);

/// ScopedModelパターンだと単発でエラーを外部に通知するのが難しいので、
/// エラーケースのみを外部に通知するためのトリック。
mixin ErrorNotifyMixin on ChangeNotifier {
  final Set<ErrorMessageCallback> _callbacks = {};

  void addOnError(ErrorMessageCallback callback) {
    _callbacks.add(callback);
  }

  void removeOnError(ErrorMessageCallback callback) {
    _callbacks.remove(callback);
  }

  void notifyError(String message) {
    _callbacks.forEach((element) => element(message));
  }
}
