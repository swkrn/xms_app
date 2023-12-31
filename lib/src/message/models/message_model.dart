// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String id;
  final String fromId;
  final String toId;
  final String message;
  final DateTime time;
  Message({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.message,
    required this.time,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] as String,
      fromId: map['from_id'] as String,
      toId: map['to_id'] as String,
      message: map['message'] as String,
      time: DateTime.parse(map['time']),
    );
  }

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, fromId: $fromId, toId: $toId, message: $message, time: $time)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.fromId == fromId &&
      other.toId == toId &&
      other.message == message &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fromId.hashCode ^
      toId.hashCode ^
      message.hashCode ^
      time.hashCode;
  }
}
