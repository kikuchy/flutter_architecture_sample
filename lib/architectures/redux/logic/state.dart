import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';

part 'state.freezed.dart';

@immutable
abstract class AppState with _$AppState {
  const factory AppState({String name, String validationError}) =
      AppStateInputting;

  const factory AppState.loading({String name}) = AppStateLoading;
}

extension AppStateExt on AppState {
  bool get valid => when(
        (name, validationError) => validationError == null,
        loading: (_) => true,
      );

  String get validationError => when(
        (name, validationError) => validationError,
        loading: (_) => null,
      );
}

@immutable
abstract class RoomListState with _$RoomListState {
  const factory RoomListState({List<Room> rooms}) = _RoomListState;
}

@immutable
abstract class RoomInsideState with _$RoomInsideState {
  const factory RoomInsideState({List<Transcript> transcripts, String draft}) =
      _RoomInsideState;

  const factory RoomInsideState.sending(
      {List<Transcript> transcripts, String draft}) = _Sending;
// なんかもうネーミングがめちゃくちゃだし分けちゃっていいのかわからないから後で再検討
}
