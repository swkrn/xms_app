import 'package:flutter/material.dart';
import 'package:xms_app/src/message/models/message_model.dart';
import 'package:xms_app/src/message/models/user_model.dart';

class MessagesPad extends StatelessWidget {
  const MessagesPad({
    super.key,
    required this.messages,
    required this.user,
    required this.withUser,
  });

  final List<Message> messages;
  final User user;
  final User withUser;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {

        return ListTile(
          title: Text(withUser.username),
        );
      },
    );
  }
}