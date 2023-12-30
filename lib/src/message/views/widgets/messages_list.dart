import 'package:flutter/material.dart';
import 'package:xms_app/src/message/models/message_pair.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required this.messagePairs,
  });

  final List<MessagePair> messagePairs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messagePairs.length,
      itemBuilder: (context, index) {
        final messagePair = messagePairs[index];
        return ListTile(
          title: Text(messagePair.firstUser.username),
          subtitle: Text(messagePair.lastTime.toString()),
        );
      },
    );
  }
}