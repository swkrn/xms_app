part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}
final class MessageAuthenticationFailed extends MessageState {}

final class MessageGetFailed extends MessageState {
  MessageGetFailed({
    required this.errorMessage,
  });
  final String errorMessage;
}

final class MessageGetSuccess extends MessageState {
  MessageGetSuccess({
    required this.messages,
    required this.user,
    required this.withUser,
  });
  final List<Message> messages;
  final User user;
  final User withUser;
}
