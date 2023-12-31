import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xms_app/utils/const_value.dart';
import 'package:xms_app/utils/exceptions.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {

    on<AuthenticationLogin>(_loginHandler);
    on<AuthenticationRegister>(_registerHandler);
    on<AuthenticationCheckToken>(_checkTokenHandler);
  }

  FutureOr<void> _loginHandler(
    AuthenticationLogin event, 
    Emitter<AuthenticationState> emit
  ) async {
    try {
      emit(AuthenticationLoading());

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

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonDecode(response.body)['token']);

      String id = jsonDecode(response.body)['id'];

      emit(AuthenticationLoginSuccess(
        id: id,
        username: username,
      ));
    }
    on APIException catch (exception) {
      emit(AuthenticationLoginFailed(errorMessage: exception.errorMessage));
    }
    catch (err) {
      emit(AuthenticationLoginFailed(errorMessage: err.toString()));
    }
  }

  FutureOr<void> _registerHandler(
    AuthenticationRegister event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(AuthenticationLoading());

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
      emit(AuthenticationRegisterFailed(errorMessage: exception.errorMessage));
    }
    catch (err) {
      emit(AuthenticationLoginFailed(errorMessage: err.toString()));
    }
  }

  FutureOr<void> _checkTokenHandler(
    AuthenticationCheckToken event, 
    Emitter<AuthenticationState> emit
  ) async {
    try {
      emit(AuthenticationLoading());
      
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('token');
      if (token == null) {
        emit(AuthenticationLoginFailed(errorMessage: 'No token'));
        return;
      }

      final response = await http.get(
        Uri.parse('$kBaseUrl/auth/is-valid-token'),
        headers: {
          'x-auth-token': token,
        },
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: jsonDecode(response.body)['msg'], 
          statusCode: response.statusCode,
        );
      }

      String id = jsonDecode(response.body)['id'];
      String username = jsonDecode(response.body)['username'];

      emit(AuthenticationLoginSuccess(
        id: id,
        username: username,
      ));
    }
    on APIException catch (exception) {
      emit(AuthenticationLoginFailed(errorMessage: exception.errorMessage));
    }
    catch (err) {
      emit(AuthenticationLoginFailed(errorMessage: err.toString()));
    }
  }
}
