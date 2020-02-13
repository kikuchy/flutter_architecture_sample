// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$AppState {
  String get name;

  AppState copyWith({String name});

  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String name, String validationError), {
    @required Result loading(String name),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String name, String validationError), {
    Result loading(String name),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(AppStateInputting value), {
    @required Result loading(AppStateLoading value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(AppStateInputting value), {
    Result loading(AppStateLoading value),
    @required Result orElse(),
  });
}

class _$AppStateInputting
    with DiagnosticableTreeMixin
    implements AppStateInputting {
  const _$AppStateInputting({this.name, this.validationError});

  @override
  final String name;
  @override
  final String validationError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'AppState(name: $name, validationError: $validationError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('validationError', validationError));
  }

  @override
  bool operator ==(dynamic other) {
    return other is AppStateInputting &&
        (identical(other.name, name) || other.name == name) &&
        (identical(other.validationError, validationError) ||
            other.validationError == validationError);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ name.hashCode ^ validationError.hashCode;

  @override
  _$AppStateInputting copyWith({
    Object name = immutable,
    Object validationError = immutable,
  }) {
    return _$AppStateInputting(
      name: name == immutable ? this.name : name as String,
      validationError: validationError == immutable
          ? this.validationError
          : validationError as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String name, String validationError), {
    @required Result loading(String name),
  }) {
    assert($default != null);
    assert(loading != null);
    return $default(name, validationError);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String name, String validationError), {
    Result loading(String name),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(name, validationError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(AppStateInputting value), {
    @required Result loading(AppStateLoading value),
  }) {
    assert($default != null);
    assert(loading != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(AppStateInputting value), {
    Result loading(AppStateLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class AppStateInputting implements AppState {
  const factory AppStateInputting({String name, String validationError}) =
      _$AppStateInputting;

  @override
  String get name;
  String get validationError;

  @override
  AppStateInputting copyWith({String name, String validationError});
}

class _$AppStateLoading
    with DiagnosticableTreeMixin
    implements AppStateLoading {
  const _$AppStateLoading({this.name});

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'AppState.loading(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState.loading'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return other is AppStateLoading &&
        (identical(other.name, name) || other.name == name);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode;

  @override
  _$AppStateLoading copyWith({
    Object name = immutable,
  }) {
    return _$AppStateLoading(
      name: name == immutable ? this.name : name as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(String name, String validationError), {
    @required Result loading(String name),
  }) {
    assert($default != null);
    assert(loading != null);
    return loading(name);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(String name, String validationError), {
    Result loading(String name),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(AppStateInputting value), {
    @required Result loading(AppStateLoading value),
  }) {
    assert($default != null);
    assert(loading != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(AppStateInputting value), {
    Result loading(AppStateLoading value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AppStateLoading implements AppState {
  const factory AppStateLoading({String name}) = _$AppStateLoading;

  @override
  String get name;

  @override
  AppStateLoading copyWith({String name});
}

mixin _$RoomListState {
  List<Room> get rooms;

  RoomListState copyWith({List<Room> rooms});
}

class _$_RoomListState with DiagnosticableTreeMixin implements _RoomListState {
  const _$_RoomListState({this.rooms});

  @override
  final List<Room> rooms;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'RoomListState(rooms: $rooms)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomListState'))
      ..add(DiagnosticsProperty('rooms', rooms));
  }

  @override
  bool operator ==(dynamic other) {
    return other is _RoomListState &&
        (identical(other.rooms, rooms) || other.rooms == rooms);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ rooms.hashCode;

  @override
  _$_RoomListState copyWith({
    Object rooms = immutable,
  }) {
    return _$_RoomListState(
      rooms: rooms == immutable ? this.rooms : rooms as List<Room>,
    );
  }
}

abstract class _RoomListState implements RoomListState {
  const factory _RoomListState({List<Room> rooms}) = _$_RoomListState;

  @override
  List<Room> get rooms;

  @override
  _RoomListState copyWith({List<Room> rooms});
}

mixin _$RoomInsideState {
  List<Transcript> get transcripts;
  String get draft;

  RoomInsideState copyWith({List<Transcript> transcripts, String draft});

  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    @required Result sending(List<Transcript> transcripts, String draft),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    Result sending(List<Transcript> transcripts, String draft),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_RoomInsideState value), {
    @required Result sending(_Sending value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_RoomInsideState value), {
    Result sending(_Sending value),
    @required Result orElse(),
  });
}

class _$_RoomInsideState
    with DiagnosticableTreeMixin
    implements _RoomInsideState {
  const _$_RoomInsideState({this.transcripts, this.draft});

  @override
  final List<Transcript> transcripts;
  @override
  final String draft;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'RoomInsideState(transcripts: $transcripts, draft: $draft)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomInsideState'))
      ..add(DiagnosticsProperty('transcripts', transcripts))
      ..add(DiagnosticsProperty('draft', draft));
  }

  @override
  bool operator ==(dynamic other) {
    return other is _RoomInsideState &&
        (identical(other.transcripts, transcripts) ||
            other.transcripts == transcripts) &&
        (identical(other.draft, draft) || other.draft == draft);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ transcripts.hashCode ^ draft.hashCode;

  @override
  _$_RoomInsideState copyWith({
    Object transcripts = immutable,
    Object draft = immutable,
  }) {
    return _$_RoomInsideState(
      transcripts: transcripts == immutable
          ? this.transcripts
          : transcripts as List<Transcript>,
      draft: draft == immutable ? this.draft : draft as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    @required Result sending(List<Transcript> transcripts, String draft),
  }) {
    assert($default != null);
    assert(sending != null);
    return $default(transcripts, draft);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    Result sending(List<Transcript> transcripts, String draft),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(transcripts, draft);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_RoomInsideState value), {
    @required Result sending(_Sending value),
  }) {
    assert($default != null);
    assert(sending != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_RoomInsideState value), {
    Result sending(_Sending value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _RoomInsideState implements RoomInsideState {
  const factory _RoomInsideState({List<Transcript> transcripts, String draft}) =
      _$_RoomInsideState;

  @override
  List<Transcript> get transcripts;
  @override
  String get draft;

  @override
  _RoomInsideState copyWith({List<Transcript> transcripts, String draft});
}

class _$_Sending with DiagnosticableTreeMixin implements _Sending {
  const _$_Sending({this.transcripts, this.draft});

  @override
  final List<Transcript> transcripts;
  @override
  final String draft;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'RoomInsideState.sending(transcripts: $transcripts, draft: $draft)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomInsideState.sending'))
      ..add(DiagnosticsProperty('transcripts', transcripts))
      ..add(DiagnosticsProperty('draft', draft));
  }

  @override
  bool operator ==(dynamic other) {
    return other is _Sending &&
        (identical(other.transcripts, transcripts) ||
            other.transcripts == transcripts) &&
        (identical(other.draft, draft) || other.draft == draft);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ transcripts.hashCode ^ draft.hashCode;

  @override
  _$_Sending copyWith({
    Object transcripts = immutable,
    Object draft = immutable,
  }) {
    return _$_Sending(
      transcripts: transcripts == immutable
          ? this.transcripts
          : transcripts as List<Transcript>,
      draft: draft == immutable ? this.draft : draft as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    @required Result sending(List<Transcript> transcripts, String draft),
  }) {
    assert($default != null);
    assert(sending != null);
    return sending(transcripts, draft);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(List<Transcript> transcripts, String draft), {
    Result sending(List<Transcript> transcripts, String draft),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (sending != null) {
      return sending(transcripts, draft);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(_RoomInsideState value), {
    @required Result sending(_Sending value),
  }) {
    assert($default != null);
    assert(sending != null);
    return sending(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(_RoomInsideState value), {
    Result sending(_Sending value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class _Sending implements RoomInsideState {
  const factory _Sending({List<Transcript> transcripts, String draft}) =
      _$_Sending;

  @override
  List<Transcript> get transcripts;
  @override
  String get draft;

  @override
  _Sending copyWith({List<Transcript> transcripts, String draft});
}
