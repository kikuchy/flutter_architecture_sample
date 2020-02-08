import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'account.dart';
import 'entities.dart';
import 'room.dart';

/// なんかそれっぽいニセモノのバックエンド
///
/// 動かすために用意したものなので気にしないでください
class DummyBackend implements AccountRepository, RoomRepository {
  final Map<String, String> _uidAndName = {};
  final Map<String, _MutableRoom> _roomIdAndRoom = {};
  final Map<String, _TranscriptStreamController> _roomIdAndTranscripts = {};

  final BehaviorSubject<String> _userStateController =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<List<Room>> _roomsStreamController =
      BehaviorSubject.seeded([]);

  static const _charsForId =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  final Random _rand = Random();
  StreamSubscription _subscription;

  DummyBackend() {
    _createDummyUsers();
    _createDummyRooms();
    _startPosting();
  }

  void _createDummyUsers() {
    const names = [
      "よしき",
      "かさね",
      "みはる",
      "おき",
      "さあや",
      "めぐみ",
      "ともき",
      "よしはる",
      "ひろし",
      "しろう",
      "ともき",
      "つかさ",
      "はるひこ",
      "ますみ",
    ];

    _uidAndName.addAll(Map.fromIterable(names,
        key: (_) => _generateId(32), value: (name) => name));
  }

  void _createDummyRooms() {
    const names = [
      "海外旅行について語れ",
      "夕飯に悩む若人のスレ",
      "Flutterって正直どうよ",
      "xPlatに明るい未来は来るのか",
      "スマホの次に来るすごいガジェットは？",
      "眠たみがやばい",
      "DroidKaigiの感想を語ろう",
      "今期の覇権アニメ",
      "がっこうぐらし！読んだ人おる？",
      "マギレコの推しカプ",
    ];

    final keys = _uidAndName.keys.toList();
    names.forEach((name) {
      final pickedMembers = List.generate(_uidAndName.length, (index) {
        return (_rand.nextBool()) ? keys[index] : null;
      }).where((element) => element != null).toList();
      createNewRoom(roomName: name, initialMembers: pickedMembers);
    });
  }

  void _startPosting() {
    _subscription = Stream.periodic(Duration(seconds: 3))
        .flatMap((_) => Rx.combineLatest2<Room, String, Future<void>>(
            Stream.value(_rand.nextInt(_roomIdAndRoom.length - 1))
                .map((roomIndex) => _roomIdAndRoom.values.toList()[roomIndex]),
            Stream.value(_rand.nextInt(_uidAndName.length - 1))
                .map((userIndex) => _uidAndName.keys.toList()[userIndex]),
            (room, uid) => postTranscript(
                roodId: room.roomId,
                uid: uid,
                content: _generateId(80))).asyncMap((future) => future))
        .listen((_) {});
  }

  String _generateId(int length) {
    return String.fromCharCodes(List.generate(length,
        (index) => _charsForId.codeUnitAt(_rand.nextInt(_charsForId.length))));
  }

  @override
  Future<String> currentUid() async => _userStateController.value;

  @override
  Stream<String> subscribeUid() {
    return _userStateController.stream;
  }

  @override
  Future<String> createAccount({@required String name}) {
    return Future.delayed(Duration(seconds: 1), () {
      final uid = _generateId(32);
      _uidAndName[uid] = name;

      _roomsStreamController.value.clear();

      _userStateController.add(uid);

      // とりあえず全室に突っ込んでおく
      _roomIdAndRoom.forEach((roomId, _) {
        addRoomMember(roomId: roomId, uid: uid);
      });

      return uid;
    });
  }

  @override
  Future<String> getAccountNameById({@required String uid}) async {
    return _uidAndName[uid];
  }

  @override
  Future<void> logout() async {
    _userStateController.add(null);
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
  Future<void> editRoomName(
      {@required String roomId, @required String newName}) async {
    _roomIdAndRoom[roomId].name = newName;
  }

  @override
  Stream<List<Transcript>> subscribeTranscripts({@required String roomId}) {
    return _roomIdAndTranscripts[roomId]?.stream;
  }

  @override
  Stream<List<Room>> subscribeRooms({@required String uid}) {
    assert(_userStateController.value == uid, "アクセス権がないっす");
    return _roomsStreamController.stream.map((allRooms) =>
        allRooms.where((room) => room.joiningMembers.contains(uid)).toList()
          ..sort((a, b) =>
              b.lastTranscriptPostedAt.compareTo(a.lastTranscriptPostedAt)));
  }

  @override
  Future<void> postTranscript(
      {@required String roodId,
      @required String uid,
      @required String content}) async {
    final now = DateTime.now();
    _roomIdAndTranscripts[roodId]
        .add(Transcript(body: content, postedAt: now, postedBy: uid));

    _roomIdAndRoom[roodId].lastTranscriptPostedAt = now;
    _roomsStreamController.add(_roomIdAndRoom.values.toList());
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

    _roomsStreamController.add(_roomIdAndRoom.values.toList());

    _roomIdAndTranscripts[roomId] = _TranscriptStreamController();

    return roomId;
  }

  void dispose() {
    _subscription.cancel();
    _roomsStreamController.close();
    _userStateController.close();
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
