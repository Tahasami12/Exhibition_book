import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/chat/data/chat_repository.dart';
import 'package:exhibition_book/features/chat/data/models/chat_model.dart';
import 'package:exhibition_book/features/chat/data/models/message_model.dart';
import 'package:exhibition_book/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:exhibition_book/features/chat/presentation/cubit/chat_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ─── Admin chats list ─────────────────────────────────────────────────────────

class AdminChatsView extends StatelessWidget {
  const AdminChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminChatsCubit(ChatRepository())..startListening(),
      child: Scaffold(
        backgroundColor: AdminTheme.bg,
        appBar: AdminTheme.adminAppBar(title: 'Support Chats', context: context),
        body: BlocBuilder<AdminChatsCubit, AdminChatsState>(
          builder: (context, state) {
            if (state is AdminChatsLoading || state is AdminChatsInitial) {
              return const Center(child: CircularProgressIndicator(color: AdminTheme.primary));
            }
            if (state is AdminChatsError) {
              return AdminTheme.errorState(state.message, () {
                context.read<AdminChatsCubit>().startListening();
              });
            }
            if (state is AdminChatsLoaded) {
              if (state.chats.isEmpty) {
                return AdminTheme.emptyState('No support chats yet.', icon: Icons.chat_bubble_outline);
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  return _ChatListTile(chat: chat);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ChatListTile extends StatelessWidget {
  final ChatModel chat;
  const _ChatListTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AdminTheme.radiusCard),
        boxShadow: AdminTheme.cardShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AdminTheme.primaryLight,
          child: Text(
            chat.userName.isNotEmpty ? chat.userName[0].toUpperCase() : '?',
            style: const TextStyle(color: AdminTheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(chat.userName,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AdminTheme.textPrimary)),
        subtitle: Text(
          chat.lastMessage.isEmpty ? 'No messages yet' : chat.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AdminTheme.textSub, fontSize: 13),
        ),
        trailing: chat.lastMessageTime != null
            ? Text(
                DateFormat('HH:mm').format(chat.lastMessageTime!),
                style: const TextStyle(color: AdminTheme.textSub, fontSize: 12),
              )
            : null,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminChatDetailsView(chat: chat),
            ),
          );
        },
      ),
    );
  }
}

// ─── Admin chat details (conversation) ───────────────────────────────────────

class AdminChatDetailsView extends StatelessWidget {
  final ChatModel chat;
  const AdminChatDetailsView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(ChatRepository())..initAdminChat(chat.chatId),
      child: _AdminChatBody(chat: chat),
    );
  }
}

class _AdminChatBody extends StatefulWidget {
  final ChatModel chat;
  const _AdminChatBody({required this.chat});

  @override
  State<_AdminChatBody> createState() => _AdminChatBodyState();
}

class _AdminChatBodyState extends State<_AdminChatBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminId = FirebaseAuth.instance.currentUser?.uid ?? 'admin';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AdminTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chat.userName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.chat.userEmail,
                style: const TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatReady) _scrollToBottom();
        },
        builder: (context, state) {
          if (state is ChatLoading || state is ChatInitial) {
            return const Center(child: CircularProgressIndicator(color: AdminTheme.primary));
          }
          if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          if (state is ChatReady) {
            return Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? Center(
                          child: Text('No messages yet.',
                              style: TextStyle(color: Colors.grey.shade500)))
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final msg = state.messages[index];
                            final isAdmin = msg.senderRole == 'admin';
                            return _AdminBubble(message: msg, isAdmin: isAdmin);
                          },
                        ),
                ),
                _buildInputBar(context, state.chatId, adminId),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, String chatId, String adminId) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Reply to user...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              _controller.clear();
              context.read<ChatCubit>().sendMessage(
                    senderId: adminId,
                    senderRole: 'admin',
                    text: text,
                  );
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AdminTheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminBubble extends StatelessWidget {
  final MessageModel message;
  final bool isAdmin;

  const _AdminBubble({required this.message, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isAdmin ? AdminTheme.primary : AppColors.grey100,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isAdmin ? const Radius.circular(18) : const Radius.circular(4),
            bottomRight: isAdmin ? const Radius.circular(4) : const Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isAdmin ? Colors.white : AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
            if (message.createdAt != null) ...[
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(message.createdAt!),
                style: TextStyle(
                  color: isAdmin ? Colors.white60 : AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
