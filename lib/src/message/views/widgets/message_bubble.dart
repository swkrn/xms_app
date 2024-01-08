import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xms_app/utils/date_time.dart';

enum MessageAlignment {
  left,
  right,
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.textMessage,
    required this.time,
    required this.alignment,
  });

  final String textMessage;
  final DateTime time;
  final MessageAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (alignment == MessageAlignment.left) 
        ? CrossAxisAlignment.start 
        : CrossAxisAlignment.end,
      children: [
        Text(
          (isToday(time))
            ? DateFormat('hh:mm').format(time)
            : DateFormat('yyyy-mm-dd - hh:mm').format(time),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: (alignment == MessageAlignment.left) 
              ? Colors.blueGrey.shade50 
              : Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text(textMessage),
        )
      ],
    );
  }
}