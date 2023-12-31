import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xms_app/src/message/models/message_pair_model.dart';
import 'package:xms_app/utils/const_value.dart';
import 'package:xms_app/utils/exceptions.dart';
import 'package:http/http.dart' as http;

part 'messages_list_event.dart';
part 'messages_list_state.dart';

class MessagesListBloc extends Bloc<MessagesListEvent, MessagesListState> {
  MessagesListBloc() : super(MessagesListInitial()) {
    on<MessagesListGetPairs>(_getPairsHandler);
  }

  FutureOr<void> _getPairsHandler(
    MessagesListGetPairs event, 
    Emitter<MessagesListState> emit
  ) async {
    try {
      emit(MessagesListLoading());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        emit(MessagesListNotAuthenticated());
        return;
      }

      final result = await http.get(
        Uri.parse('$kBaseUrl/message/messages-list'),
        headers: {
          'x-auth-token': token,
        }
      );

      if (result.statusCode != 200) {
        throw APIException(
          message: jsonDecode(result.body)['msg'], 
          statusCode: result.statusCode,
        );
      }

      final messagePairs = 
        List<Map<String, dynamic>>.from(jsonDecode(result.body))
        .map((element) => MessagePair.fromMap(element),)
        .toList();

      emit(MessagesListLoadSuccess(messagePairs: messagePairs));
    }
    on APIException catch (exception) {
      emit(MessagesListLoadFailed(
        errorMessage: exception.errorMessage,
      ));
    }
    catch (err) {
      emit(MessagesListLoadFailed(errorMessage: err.toString()));
    }
  }
}
