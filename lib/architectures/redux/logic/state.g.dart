// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension AppStateCopyWithExtension on AppState {
  AppState copyWith({
    RegistrationState registrationState,
    RoomInsideState roomInsideState,
    RoomListState roomListState,
  }) {
    return AppState(
      registrationState: registrationState ?? this.registrationState,
      roomInsideState: roomInsideState ?? this.roomInsideState,
      roomListState: roomListState ?? this.roomListState,
    );
  }
}

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension RegistrationStateCopyWithExtension on RegistrationState {
  RegistrationState copyWith({
    bool loading,
    String name,
    bool valid,
    String validationError,
  }) {
    return RegistrationState(
      loading: loading ?? this.loading,
      name: name ?? this.name,
      valid: valid ?? this.valid,
      validationError: validationError ?? this.validationError,
    );
  }
}

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension RoomListStateCopyWithExtension on RoomListState {
  RoomListState copyWith({
    List rooms,
    StreamSubscription subscription,
  }) {
    return RoomListState(
      rooms: rooms ?? this.rooms,
      subscription: subscription ?? this.subscription,
    );
  }
}

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension RoomInsideStateCopyWithExtension on RoomInsideState {
  RoomInsideState copyWith({
    String draft,
    String roomId,
    bool sending,
    StreamSubscription subscription,
    List transcripts,
    bool valid,
  }) {
    return RoomInsideState(
      draft: draft ?? this.draft,
      roomId: roomId ?? this.roomId,
      sending: sending ?? this.sending,
      subscription: subscription ?? this.subscription,
      transcripts: transcripts ?? this.transcripts,
      valid: valid ?? this.valid,
    );
  }
}
