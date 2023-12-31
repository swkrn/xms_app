part of 'messages_list_bloc.dart';

@immutable
sealed class MessagesListState {}

final class MessagesListInitial extends MessagesListState {}

final class MessagesListLoading extends MessagesListState {}

final class MessagesListLoadSuccess extends MessagesListState {
  MessagesListLoadSuccess({
    required this.messagePairs,
  });
  final List<MessagePair> messagePairs;
}

final class MessagesListLoadFailed extends MessagesListState {
  MessagesListLoadFailed({
    required this.errorMessage,
  });
  final String errorMessage;
}

final class MessagesListNotAuthenticated extends MessagesListState {}