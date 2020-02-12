// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

abstract class _$AppState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notLoggedIn(String name),
    @required Result LoggedIn(String currentUid),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notLoggedIn(String name),
    Result LoggedIn(String currentUid),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notLoggedIn(NotLoggedIn value),
    @required Result LoggedIn(LoggedIn value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notLoggedIn(NotLoggedIn value),
    Result LoggedIn(LoggedIn value),
    @required Result orElse(),
  });
}

class _$NotLoggedIn with DiagnosticableTreeMixin implements NotLoggedIn {
  const _$NotLoggedIn({this.name});

  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'AppState.notLoggedIn(name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState.notLoggedIn'))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return other is NotLoggedIn &&
        (identical(other.name, name) || other.name == name);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ name.hashCode;

  @override
  _$NotLoggedIn copyWith({
    Object name = immutable,
  }) {
    return _$NotLoggedIn(
      name: name == immutable ? this.name : name as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notLoggedIn(String name),
    @required Result LoggedIn(String currentUid),
  }) {
    assert(notLoggedIn != null);
    assert(LoggedIn != null);
    return notLoggedIn(name);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notLoggedIn(String name),
    Result LoggedIn(String currentUid),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notLoggedIn != null) {
      return notLoggedIn(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notLoggedIn(NotLoggedIn value),
    @required Result LoggedIn(LoggedIn value),
  }) {
    assert(notLoggedIn != null);
    assert(LoggedIn != null);
    return notLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notLoggedIn(NotLoggedIn value),
    Result LoggedIn(LoggedIn value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notLoggedIn != null) {
      return notLoggedIn(this);
    }
    return orElse();
  }
}

abstract class NotLoggedIn implements AppState {
  const factory NotLoggedIn({String name}) = _$NotLoggedIn;

  String get name;

  NotLoggedIn copyWith({String name});
}

class _$LoggedIn with DiagnosticableTreeMixin implements LoggedIn {
  const _$LoggedIn({this.currentUid});

  @override
  final String currentUid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return 'AppState.LoggedIn(currentUid: $currentUid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState.LoggedIn'))
      ..add(DiagnosticsProperty('currentUid', currentUid));
  }

  @override
  bool operator ==(dynamic other) {
    return other is LoggedIn &&
        (identical(other.currentUid, currentUid) ||
            other.currentUid == currentUid);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ currentUid.hashCode;

  @override
  _$LoggedIn copyWith({
    Object currentUid = immutable,
  }) {
    return _$LoggedIn(
      currentUid:
          currentUid == immutable ? this.currentUid : currentUid as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notLoggedIn(String name),
    @required Result LoggedIn(String currentUid),
  }) {
    assert(notLoggedIn != null);
    assert(LoggedIn != null);
    return LoggedIn(currentUid);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notLoggedIn(String name),
    Result LoggedIn(String currentUid),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (LoggedIn != null) {
      return LoggedIn(currentUid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notLoggedIn(NotLoggedIn value),
    @required Result LoggedIn(LoggedIn value),
  }) {
    assert(notLoggedIn != null);
    assert(LoggedIn != null);
    return LoggedIn(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notLoggedIn(NotLoggedIn value),
    Result LoggedIn(LoggedIn value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (LoggedIn != null) {
      return LoggedIn(this);
    }
    return orElse();
  }
}

abstract class LoggedIn implements AppState {
  const factory LoggedIn({String currentUid}) = _$LoggedIn;

  String get currentUid;

  LoggedIn copyWith({String currentUid});
}

abstract class _$RoomListState {
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

abstract class _$RoomInsideState {
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
