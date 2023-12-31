part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationLoginFailed extends AuthenticationState {
  AuthenticationLoginFailed({
    required this.errorMessage,
  });
  final String errorMessage;
}

final class AuthenticationLoginSuccess extends AuthenticationState {
  AuthenticationLoginSuccess({
    required this.id,
    required this.username,
  });

  final String id;
  final String username;
}


final class AuthenticationRegisterFailed extends AuthenticationState {
  AuthenticationRegisterFailed({
    required this.errorMessage,
  });
  final String errorMessage;
}

final class AuthenticationRegisterSuccess extends AuthenticationState {}

