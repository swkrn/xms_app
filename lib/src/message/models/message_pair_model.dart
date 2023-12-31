// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:xms_app/src/message/models/user_model.dart';

class MessagePair {
  
  final String id;
  final User pairUser;
  final String lastMessage;
  final DateTime lastTime;

  MessagePair({
    required this.id,
    required this.pairUser,
    required this.lastMessage,
    required this.lastTime,
  });

  MessagePair copyWith({
    String? id,
    User? pairUser,
    String? lastMessage,
    DateTime? lastTime,
  }) {
    return MessagePair(
      id: id ?? this.id,
      pairUser: pairUser ?? this.pairUser,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTime: lastTime ?? this.lastTime,
    );
  }

  factory MessagePair.fromMap(Map<String, dynamic> map) {
    return MessagePair(
      id: map['_id'] as String,
      pairUser: User.fromMap(map['pair_user'] as Map<String,dynamic>),
      lastMessage: map['last_message'] as String,
      lastTime: DateTime.parse(map['last_time']),
    );
  }

  factory MessagePair.fromJson(String source) => MessagePair.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessagePair(id: $id, pairUser: $pairUser, lastTime: $lastTime)';

  @override
  bool operator ==(covariant MessagePair other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.pairUser == pairUser &&
      other.lastTime == lastTime;
  }

  @override
  int get hashCode => id.hashCode ^ pairUser.hashCode ^ lastTime.hashCode;
}
