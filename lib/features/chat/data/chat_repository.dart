import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_book/features/chat/data/models/chat_model.dart';
import 'package:exhibition_book/features/chat/data/models/message_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _chats => _firestore.collection('chats');

  // ─── Get or create the user's chat doc ────────────────────────────────────
  Future<String> getOrCreateChat({
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    // Check if chat already exists for this user
    final existing = await _chats
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      return existing.docs.first.id;
    }

    // Create new chat doc
    final docRef = await _chats.add({
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'lastMessage': '',
      'lastMessageTime': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  // ─── Stream of messages (real-time) ────────────────────────────────────────
  Stream<List<MessageModel>> messagesStream(String chatId) {
    return _chats
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => MessageModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  // ─── Send a message ────────────────────────────────────────────────────────
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String senderRole, // 'user' or 'admin'
    required String text,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    // Add to messages subcollection
    await _chats.doc(chatId).collection('messages').add({
      'senderId': senderId,
      'senderRole': senderRole,
      'text': trimmed,
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // Update chat metadata
    await _chats.doc(chatId).update({
      'lastMessage': trimmed,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ─── Admin: stream of all chats ────────────────────────────────────────────
  Stream<List<ChatModel>> allChatsStream() {
    return _chats
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => ChatModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
}
