import 'package:flutter/material.dart';
import 'package:xms_app/src/message/models/message_model.dart';
import 'package:xms_app/src/message/models/user_model.dart';
import 'package:xms_app/src/message/views/widgets/message_bubble.dart';

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
        final Message message = messages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: MessageBubble(
            textMessage: message.message, 
            time: message.time,
            alignment: (withUser.id == message.fromId) 
              ? MessageAlignment.left
              : MessageAlignment.right
          )
        );
      },
      reverse: true,
    );
  }
}