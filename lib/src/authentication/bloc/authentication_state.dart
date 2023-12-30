part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationLoginFailed extends AuthenticationState {
  AuthenticationLoginFailed({
    required this.message,
  });
  final String message;
}

final class AuthenticationLoginSuccess extends AuthenticationState {}


final class AuthenticationRegisterFailed extends AuthenticationState {
  AuthenticationRegisterFailed({
    required this.message,
  });
  final String message;
}

final class AuthenticationRegisterSuccess extends AuthenticationState {}

