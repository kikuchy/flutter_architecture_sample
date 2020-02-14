// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension AppStateCopyWithExtension on AppState {
  AppState copyWith({
    RegistrationState registrationState,
    RoomListState roomListState,
  }) {
    return AppState(
      registrationState: registrationState ?? this.registrationState,
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
    bool sending,
    List transcripts,
  }) {
    return RoomInsideState(
      draft: draft ?? this.draft,
      sending: sending ?? this.sending,
      transcripts: transcripts ?? this.transcripts,
    );
  }
}
