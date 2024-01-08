import 'package:flutter/material.dart';
import 'package:xms_app/src/message/models/message_pair_model.dart';
import 'package:intl/intl.dart';
import 'package:xms_app/src/message/models/user_model.dart';

class MessagesPairList extends StatelessWidget {
  const MessagesPairList({
    super.key,
    required this.messagePairs,
    required this.context,
  });

  final List<MessagePair> messagePairs;
  final BuildContext context;

  void navigateToMessage(String id, String username) {
    Navigator.of(context).pushNamed(
      '/message',
      arguments: User(id: id, username: username),
    );
  }

  @override
  Widget build(BuildContext context) {
    return(messagePairs.isEmpty) 
      ? const Center(child: Text('No message(s)'),)
      : ListView.builder(
        itemCount: messagePairs.length,
        itemBuilder: (context, index) {
          final messagePair = messagePairs[index];
          return ListTile(
            title: Text(
              messagePair.pairUser.username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(messagePair.lastMessage),
            trailing: Text(
              DateFormat('yyyy-MM-dd — hh:mm').format(messagePair.lastTime),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              navigateToMessage(messagePair.pairUser.id, messagePair.pairUser.username);
            },
          );
        },
      );
    }
}