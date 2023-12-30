// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:xms_app/src/message/models/user.dart';

class MessagePair {
  MessagePair({
    required this.id,
    required this.firstUser,
    required this.secondUser,
    required this.lastTime,
  });

  final String id;
  final User firstUser;
  final User secondUser;
  final DateTime lastTime;

  MessagePair copyWith({
    String? id,
    User? firstUser,
    User? secondUser,
    DateTime? lastTime,
  }) {
    return MessagePair(
      id: id ?? this.id,
      firstUser: firstUser ?? this.firstUser,
      secondUser: secondUser ?? this.secondUser,
      lastTime: lastTime ?? this.lastTime,
    );
  }

  factory MessagePair.fromMap(Map<String, dynamic> map) {
    return MessagePair(
      id: map['_id'] as String,
      firstUser: User.fromMap(map['first_id'] as Map<String,dynamic>),
      secondUser: User.fromMap(map['second_id'] as Map<String,dynamic>),
      lastTime: DateTime.parse(map['last_time'] as String),
      
    );
  }

  factory MessagePair.fromJson(String source) => MessagePair.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessagePair(id: $id, firstUser: $firstUser, secondUser: $secondUser, lastTime: $lastTime)';
  }

  @override
  bool operator ==(covariant MessagePair other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstUser == firstUser &&
      other.secondUser == secondUser &&
      other.lastTime == lastTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstUser.hashCode ^
      secondUser.hashCode ^
      lastTime.hashCode;
  }
}
