import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';

part 'state.freezed.dart';

@immutable
abstract class AppState extends _$AppState {
  const factory AppState.notLoggedIn({String name}) = NotLoggedIn;
  const factory AppState.LoggedIn({String currentUid}) = LoggedIn;
}

@immutable
abstract class RoomListState extends _$RoomListState {
  const factory RoomListState({List<Room> rooms}) = _RoomListState;
}

@immutable
abstract class RoomInsideState extends _$RoomInsideState {
  const factory RoomInsideState({List<Transcript> transcripts, String draft}) = _RoomInsideState;
  const factory RoomInsideState.sending({List<Transcript> transcripts, String draft}) = _Sending;
  // なんかもうネーミングがめちゃくちゃだし分けちゃっていいのかわからないから後で再検討
}
