part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class AuthenticationLogin extends AuthenticationEvent {
  AuthenticationLogin({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

final class AuthenticationRegister extends AuthenticationEvent {
  AuthenticationRegister({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
