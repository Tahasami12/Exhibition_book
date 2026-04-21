import 'package:exhibition_book/features/chat/data/models/chat_model.dart';
import 'package:exhibition_book/features/chat/data/models/message_model.dart';

// ─── Chat init state ──────────────────────────────────────────────────────────
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatReady extends ChatState {
  final String chatId;
  final List<MessageModel> messages;
  ChatReady({required this.chatId, required this.messages});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

// ─── Admin chats list ─────────────────────────────────────────────────────────
abstract class AdminChatsState {}

class AdminChatsInitial extends AdminChatsState {}

class AdminChatsLoading extends AdminChatsState {}

class AdminChatsLoaded extends AdminChatsState {
  final List<ChatModel> chats;
  AdminChatsLoaded(this.chats);
}

class AdminChatsError extends AdminChatsState {
  final String message;
  AdminChatsError(this.message);
}
