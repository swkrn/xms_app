import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/message/bloc/message_bloc.dart';
import 'package:xms_app/src/message/models/message_model.dart';
import 'package:xms_app/utils/socket_client.dart';

class MessageSocket {
  final _socketClient = SocketClient.instance.socket!;

  void joinMessages(String fromToken) {
    _socketClient.emit('join-messages', {
      'from_token': fromToken,
    });
  }

  void sendMessage({
    required String fromToken,
    required String toId,
    required String message,
  }) {
    _socketClient.emit('send-message', {
      'from_token': fromToken,
      'to_id': toId,
      'message': message
    });
  }

  void messageListener({
    required MessageGetSuccess currentMessageGetSuccess,
    required VoidCallback onStateChanged,
  }) {
    _socketClient.on('recieve-message', (msg) {

      currentMessageGetSuccess.messages.add(Message.fromMap(msg));
      onStateChanged();
    });
  }

}