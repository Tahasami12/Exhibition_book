import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String senderRole; // 'user' or 'admin'
  final String text;
  final DateTime? createdAt;
  final bool isRead;

  const MessageModel({
    required this.id,
    required this.senderId,
    required this.senderRole,
    required this.text,
    this.createdAt,
    this.isRead = false,
  });

  factory MessageModel.fromFirestore(Map<String, dynamic> json, String id) {
    return MessageModel(
      id: id,
      senderId: json['senderId'] ?? '',
      senderRole: json['senderRole'] ?? 'user',
      text: json['text'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'senderRole': senderRole,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': isRead,
      };
}
