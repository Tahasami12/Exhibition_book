import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String userId;
  final String userName;
  final String userEmail;
  final String lastMessage;
  final DateTime? lastMessageTime;
  final DateTime? createdAt;

  const ChatModel({
    required this.chatId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.lastMessage,
    this.lastMessageTime,
    this.createdAt,
  });

  factory ChatModel.fromFirestore(Map<String, dynamic> json, String id) {
    return ChatModel(
      chatId: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Unknown',
      userEmail: json['userEmail'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: (json['lastMessageTime'] as Timestamp?)?.toDate(),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime != null
            ? Timestamp.fromDate(lastMessageTime!)
            : null,
        'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
