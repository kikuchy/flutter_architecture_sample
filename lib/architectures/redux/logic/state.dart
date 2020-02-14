import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_architecture_samples/common/repository/entities.dart';

part 'state.g.dart';

@CopyWith()
class AppState {
  final RegistrationState registrationState;
  final RoomListState roomListState;
  final RoomInsideState roomInsideState;

  const AppState({
    this.registrationState,
    this.roomListState,
    this.roomInsideState,
  });

  factory AppState.initial() => AppState(
        registrationState: RegistrationState.initial(),
        roomListState: RoomListState.initial(),
        roomInsideState: RoomInsideState.initial(),
      );
}

@CopyWith()
class RegistrationState {
  final String name;
  final String validationError;
  final bool valid;
  final bool loading;

  const RegistrationState(
      {this.name, this.validationError, this.valid, this.loading});

  factory RegistrationState.initial() => RegistrationState(
      name: "", validationError: "", valid: false, loading: false);
}

@CopyWith()
class RoomListState {
  final List<Room> rooms;
  final StreamSubscription<List<Room>> subscription;

  const RoomListState({this.rooms, this.subscription});

  factory RoomListState.initial() =>
      RoomListState(rooms: null, subscription: null);
}

@CopyWith()
class RoomInsideState {
  final List<Transcript> transcripts;
  final StreamSubscription<List<Transcript>> subscription;
  final String draft;
  final bool sending;

  const RoomInsideState(
      {this.transcripts, this.draft, this.sending, this.subscription});

  factory RoomInsideState.initial() => RoomInsideState(
      transcripts: [], draft: "", sending: false, subscription: null);
}
