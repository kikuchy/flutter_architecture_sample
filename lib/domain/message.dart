import 'login.dart';

class MessageActionStartSubscribe {}

class MessageActionArriveNewMessage {
  final String newMessage;

  MessageActionArriveNewMessage(this.newMessage);
}

abstract class MessageState {
  final List<String> messages;

  const MessageState([this.messages = const []]);
}

class MessageStateSubscribing extends MessageState {
  const MessageStateSubscribing([List<String> messages]) : super(messages);
}

LoginState Function(LoginState, dynamic)
    _messageReducer<S extends MessageState, A>(
        MessageState Function(S, A) reducer) {
  return needsLoginTypedAction<A>((state, action) {
    if (state.memberState is S) {
      final newMessageState = reducer(state.messageState, action);
      return state.edit(messageState: newMessageState);
    }
    return state;
  });
}
