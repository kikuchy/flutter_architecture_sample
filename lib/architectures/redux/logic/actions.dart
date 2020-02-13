class ValidateName {
  final String name;

  ValidateName(this.name);
}

class Login {}

class LoggedInSuccessfully {}

class LoggedInFailed {}

class StartSubscribingRoom {
  final String roomId;

  StartSubscribingRoom(this.roomId);
}

class SendMessage {
  final String body;

  SendMessage(this.body);
}
