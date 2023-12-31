part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

final class MessageGetMessages extends MessageEvent {
  final User withUser;

  MessageGetMessages({required this.withUser});
}