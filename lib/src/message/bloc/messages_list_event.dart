part of 'messages_list_bloc.dart';

@immutable
sealed class MessagesListEvent {}

final class MessagesListGetPairs extends MessagesListEvent {}