import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/chat/data/chat_repository.dart';
import 'package:exhibition_book/features/chat/presentation/cubit/chat_state.dart';

/// Handles the user's individual chat screen.
class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repo;
  StreamSubscription? _messagesSub;
  String? _currentChatId;

  ChatCubit(this._repo) : super(ChatInitial());

  // ─── Initialize user chat ─────────────────────────────────────────────────
  Future<void> initUserChat({
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    emit(ChatLoading());
    try {
      final chatId = await _repo.getOrCreateChat(
        userId: userId,
        userName: userName,
        userEmail: userEmail,
      );
      _currentChatId = chatId;
      _listenToMessages(chatId);
    } catch (e) {
      emit(ChatError('Failed to open chat: $e'));
    }
  }

  // ─── Listen to messages stream ────────────────────────────────────────────
  void initAdminChat(String chatId) {
    _currentChatId = chatId;
    _listenToMessages(chatId);
  }

  void _listenToMessages(String chatId) {
    _messagesSub?.cancel();
    _messagesSub = _repo.messagesStream(chatId).listen(
      (messages) {
        emit(ChatReady(chatId: chatId, messages: messages));
      },
      onError: (e) {
        emit(ChatError('Failed to load messages: $e'));
      },
    );
  }

  // ─── Send message ─────────────────────────────────────────────────────────
  Future<void> sendMessage({
    required String senderId,
    required String senderRole,
    required String text,
  }) async {
    if (_currentChatId == null) return;
    try {
      await _repo.sendMessage(
        chatId: _currentChatId!,
        senderId: senderId,
        senderRole: senderRole,
        text: text,
      );
    } catch (_) {
      // silently ignore send errors — the stream will not update
    }
  }

  @override
  Future<void> close() {
    _messagesSub?.cancel();
    return super.close();
  }
}

/// Handles the admin chats list.
class AdminChatsCubit extends Cubit<AdminChatsState> {
  final ChatRepository _repo;
  StreamSubscription? _sub;

  AdminChatsCubit(this._repo) : super(AdminChatsInitial());

  void startListening() {
    emit(AdminChatsLoading());
    _sub = _repo.allChatsStream().listen(
      (chats) => emit(AdminChatsLoaded(chats)),
      onError: (e) => emit(AdminChatsError('$e')),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
