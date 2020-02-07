import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/repository/account.dart';
import 'package:flutter_architecture_samples/repository/entities.dart';
import 'package:flutter_architecture_samples/repository/room.dart';

/// なんかそれっぽいニセモノのバックエンド
///
/// 動かすために用意したものなので気にしないでください
class DummyBackend implements AccountRepository, RoomRepository {
  final Map<String, String> _uidAndName = {};
  final Map<String, _MutableRoom> _roomIdAndRoom = {};
  final Map<String, _TranscriptStreamController> _roomIdAndTranscripts = {};

  String _currentUser;
  final List<Room> _roomsCurrentUserBelonging = [];
  final StreamController<List<Room>> _roomsStream =
      StreamController.broadcast();

  static const _charsForId =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  final Random _rand = Random();

  String _generateId(int length) {
    return String.fromCharCodes(List.generate(length,
        (index) => _charsForId.codeUnitAt(_rand.nextInt(_charsForId.length))));
  }

  @override
  Future<String> currentUid() async => _currentUser;

  @override
  Future<String> createAccount({@required String name}) async {
    _currentUser = _generateId(32);
    _uidAndName[_currentUser] = name;

    _roomsCurrentUserBelonging.clear();

    return _currentUser;
  }

  @override
  Future<String> getAccountNameById({@required String uid}) async {
    return _uidAndName[uid];
  }

  @override
  Future<void> removeRoomMember(
      {@required String roomId, @required String uid}) async {
    _roomIdAndRoom[roomId].joiningMembers.remove(uid);
  }

  @override
  Future<void> addRoomMember(
      {@required String roomId, @required String uid}) async {
    _roomIdAndRoom[roomId].joiningMembers.add(uid);
  }

  @override
  Future<List<String>> membersOfRoom({@required String roomId}) async {
    return _roomIdAndRoom[roomId].joiningMembers;
  }

  @override
  Future<Function> editRoomName(
      {@required String roomId, @required String newName}) async {
    _roomIdAndRoom[roomId].name = newName;
  }

  @override
  Stream<List<Transcript>> subscribeTranscripts({@required String roomId}) {
    return _roomIdAndTranscripts[roomId]?.stream;
  }

  @override
  Stream<List<Room>> subscribeRooms({@required String uid}) {
    assert(_currentUser == uid, "アクセス権がないっす");
    return _roomsStream.stream;
  }

  @override
  Future<Function> postTranscript(
      {@required String roodId,
      @required String uid,
      @required String content}) {
    final now = DateTime.now();
    _roomIdAndTranscripts[roodId]
        .add(Transcript(body: content, postedAt: now, postedBy: uid));

    _roomIdAndRoom[roodId].lastTranscriptPostedAt = now;
    _roomsCurrentUserBelonging.sort(
        (a, b) => a.lastTranscriptPostedAt.compareTo(b.lastTranscriptPostedAt));
  }

  @override
  Future<String> createNewRoom(
      {@required String roomName,
      List<String> initialMembers = const []}) async {
    final roomId = _generateId(64);
    _roomIdAndRoom[roomId] = _MutableRoom()
      ..roomId = roomId
      ..name = roomName
      ..joiningMembers = initialMembers
      ..lastTranscriptPostedAt = DateTime.now();

    _roomsCurrentUserBelonging.add(_roomIdAndRoom[roomId]);
    _roomsStream.add(_roomsCurrentUserBelonging);

    _roomIdAndTranscripts[roomId] = _TranscriptStreamController();

    return roomId;
  }

  void dispose() {
    _roomsStream.close();
    _roomIdAndTranscripts.forEach((key, value) {
      value.close();
    });
  }
}

class _MutableRoom implements Room {
  String roomId;
  String name;
  List<String> joiningMembers;
  DateTime lastTranscriptPostedAt;
}

class _TranscriptStreamController {
  final List<Transcript> _log = [];
  final StreamController<List<Transcript>> _controller =
      StreamController.broadcast();

  Stream<List<Transcript>> get stream => _controller.stream;

  void add(Transcript transcript) {
    _log.add(transcript);
    _controller.add(_log);
  }

  void close() {
    _controller.close();
  }
}
