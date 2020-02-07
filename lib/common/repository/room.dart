import 'package:flutter/foundation.dart';
import 'entities.dart';

/// チャットルームの管理を行うバックエンド操作を抽象化した君
abstract class RoomRepository {
  /// 新しいチャットルームを作り、チャットルームIDを返します。
  Future<String> createNewRoom(
      {@required String roomName, List<String> initialMembers = const []});

  /// 指定したユーザーIDの人が参加しているチャットルームの様子を監視します。
  ///
  /// 実際にはgRPCを使う、一定時間でポーリングするなどの方法で実現する想定です。
  Stream<List<Room>> subscribeRooms({@required String uid});

  /// 指定したチャットルームの会話を監視します。
  Stream<List<Transcript>> subscribeTranscripts({@required String roomId});

  /// 指定したチャットルームに新しい発言をします。
  Future<void> postTranscript(
      {@required String roodId,
      @required String uid,
      @required String content});

  /// チャットルームの名前を変更します。
  Future<void> editRoomName(
      {@required String roomId, @required String newName});

  /// チャットルームに参加している人たちのIDを返します。
  Future<List<String>> membersOfRoom({@required String roomId});

  /// チャットルームに人を追加します。
  Future<void> addRoomMember({@required String roomId, @required String uid});

  /// チャットルームから人を追い出します。
  Future<void> removeRoomMember(
      {@required String roomId, @required String uid});
}
