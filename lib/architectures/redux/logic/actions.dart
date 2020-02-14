import 'dart:async';

import 'package:flutter_architecture_samples/common/repository/entities.dart';

class ValidateName {
  final String name;

  ValidateName(this.name);
}

class Register {}

class RegisteredSuccessfully {}

class RegisteredFailed {}

class StartSubscribingRoomList {}

class RoomListSubscribingStarted {
  final StreamSubscription<List<Room>> subscription;

  RoomListSubscribingStarted(this.subscription);
}

class RoomListUpdated {
  final List<Room> rooms;

  RoomListUpdated(this.rooms);
}

class StartSubscribingRoom {
  final String roomId;

  StartSubscribingRoom(this.roomId);
}

class TranscriptSubscriptionStarted {
  final StreamSubscription<List<Transcript>> subscription;

  TranscriptSubscriptionStarted(this.subscription);
}

class TranscriptUpdated {
  final List<Transcript> transcripts;

  TranscriptUpdated(this.transcripts);
}

class SendMessage {
  final String body;

  SendMessage(this.body);
}
