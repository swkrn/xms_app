import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xms_app/src/message/models/message_model.dart';
import 'package:xms_app/src/message/models/user_model.dart';
import 'package:xms_app/src/message/sockets/message_socket.dart';
import 'package:xms_app/utils/const_value.dart';
import 'package:xms_app/utils/exceptions.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<MessageGetMessages>(_getMessagesHandler);
    on<MessageSendMessage>(_sendMessageHandler);
  }

  FutureOr<void> _getMessagesHandler(
    MessageGetMessages event, 
    Emitter<MessageState> emit
  ) async {
    try {
      emit(MessageLoading());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        emit(MessageAuthenticationFailed());
        return;
      }

      final headers = {
          'x-auth-token': token,
        };

      final validateResult = await http.get(
        Uri.parse('$kBaseUrl/auth/is-valid-token'),
        headers: headers,
      );

      if (validateResult.statusCode != 200) {
        emit(MessageAuthenticationFailed());
        return;
      }

      String id = jsonDecode(validateResult.body)['id'];
      String username =jsonDecode(validateResult.body)['username'];
      String toId = event.withUser.id;

      final result = await http.get(
        Uri.parse('$kBaseUrl/message/all-messages/$toId'),
        headers: headers,
      );


      if (result.statusCode != 200) {
        throw APIException(message: result.body, statusCode: result.statusCode);
      }

      final messages = List<Map<String, dynamic>>.from(jsonDecode(result.body))
        .map((e) => Message.fromMap(e))
        .toList();

      emit(MessageGetSuccess(
        messages: messages,
        user: User(id: id, username: username),
        withUser: event.withUser,
      ));
    }
    on APIException catch (exception) {
      emit(MessageGetFailed(errorMessage: exception.errorMessage));
    }
    catch (err) {
      emit(MessageGetFailed(errorMessage: err.toString()));
    }
  }

  FutureOr<void> _sendMessageHandler(
    MessageSendMessage event, 
    Emitter<MessageState> emit
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        emit(MessageAuthenticationFailed());
        return;
      }

      final headers = {
          'x-auth-token': token,
        };

      final validateResult = await http.get(
        Uri.parse('$kBaseUrl/auth/is-valid-token'),
        headers: headers,
      );

      if (validateResult.statusCode != 200) {
        emit(MessageAuthenticationFailed());
        return;
      }

      String id = jsonDecode(validateResult.body)['id'];

      final messageSocket = MessageSocket();

      messageSocket.sendMessage(
        fromToken: token,
        toId: event.withUser.id,
        message: event.textMessage,
      );
    }
    on APIException catch (exception) {
      emit(MessageSendFailed(errorMessage: exception.message));
    }
    catch (err) {
      emit(MessageSendFailed(errorMessage: err.toString()));
    }
  }
}
