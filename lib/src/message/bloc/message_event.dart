part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

final class MessageGetMessages extends MessageEvent {
  final User withUser;

  MessageGetMessages({required this.withUser});
}

final class MessageSendMessage extends MessageEvent {
  final String textMessage;
  final User withUser;

  MessageSendMessage({
    required this.textMessage,
    required this.withUser,
  });
}