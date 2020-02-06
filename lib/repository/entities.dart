import 'package:flutter/foundation.dart';

/// チャット内の発言
class Transcript {
  final String body;
  final DateTime postedAt;
  final String postedBy;

  Transcript({
    @required this.body,
    @required this.postedAt,
    @required this.postedBy,
  });
}

/// チャットルーム
class Room {
  final String roomId;
  final String name;
  final List<String> joiningMembers;
  final DateTime lastTranscriptPostedAt;

  Room({
    @required this.roomId,
    @required this.name,
    @required this.joiningMembers,
    @required this.lastTranscriptPostedAt,
  });
}
