import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:xms_app/utils/const_value.dart';
import 'package:xms_app/utils/exceptions.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {

    on<AuthenticationLogin>(_loginHandler);
    on<AuthenticationRegister>(_registerHandler);
  }



  FutureOr<void> _loginHandler(
    AuthenticationLogin event, 
    Emitter<AuthenticationState> emit
  ) async {
    try {
      emit(AuthenticationLoggingIn());

      final username = event.username;
      final password = event.password;

      final body = jsonEncode({
        'username': username,
        'password': password,
      });

      final response = await http.post(
        Uri.parse('$kBaseUrl/auth/login'),
        body: body,
        headers: {
          'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: jsonDecode(response.body)['msg'],
          statusCode: response.statusCode
        );
      }
      emit(AuthenticationLoginSuccess());
    }
    on APIException catch (exception) {
      emit(AuthenticationLoginFailed(message: exception.errorMessage));
    }
  }

  FutureOr<void> _registerHandler(
    AuthenticationRegister event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(AuthenticationRegistering());

      final username = event.username;
      final password = event.password;

      final body = jsonEncode({
        'username': username,
        'password': password,
      });

      final response = await http.post(
        Uri.parse('$kBaseUrl/auth/register'),
        body: body,
        headers: {
          'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: jsonDecode(response.body)['msg'],
          statusCode: response.statusCode
        );
      }

      emit(AuthenticationRegisterSuccess());
    }
    on APIException catch (exception) {
      emit(AuthenticationRegisterFailed(message: exception.errorMessage));
    }
  }
}
