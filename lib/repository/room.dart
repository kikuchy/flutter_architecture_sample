import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_samples/repository/entities.dart';

/// チャットルームの管理を行うバックエンド操作を抽象化した君
class RoomRepository {
  Future<String> createNewRoom({@required String roomName}) {}

  Stream<List<Room>> subscribeRooms({@required String uid}) {}

  Stream<List<Transcript>> subscribeTranscripts({@required String roomId}) {}
}
