class ValidateName {
  final String name;

  ValidateName(this.name);
}

class Register {}

class RegisteredSuccessfully {}

class RegisteredFailed {}

class StartSubscribingRoom {
  final String roomId;

  StartSubscribingRoom(this.roomId);
}

class SendMessage {
  final String body;

  SendMessage(this.body);
}
