import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_state.dart';
import '../../../../core/services/fcm_service.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState()) {
    _listenToAuth();
  }

  StreamSubscription<User?>? _authSub;
  StreamSubscription<QuerySnapshot>? _ordersSub;
  StreamSubscription<QuerySnapshot>? _promosSub;
  StreamSubscription<QuerySnapshot>? _chatSub;
  StreamSubscription<QuerySnapshot>? _chatMessagesSub;

  // ─── Listen to auth changes ──────────────────────────────────────────────────
  void _listenToAuth() {
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _startListening(user.uid);
      } else {
        _stopListening();
        emit(const NotificationState());
      }
    });
  }

  bool _isFirstOrdersLoad = true;
  bool _isFirstPromosLoad = true;
  bool _isFirstChatLoad = true;

  void _startListening(String userId) {
    // Cancel any existing subscriptions
    _ordersSub?.cancel();
    _promosSub?.cancel();
    _chatSub?.cancel();
    _chatMessagesSub?.cancel();

    _isFirstOrdersLoad = true;
    _isFirstPromosLoad = true;
    _isFirstChatLoad = true;

    // Listen to user orders from Firestore
    _ordersSub = FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      int newCount = 0;
      if (!_isFirstOrdersLoad) {
        for (var change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified) {
            newCount++;
            final data = change.doc.data();
            if (data != null) {
              final status = data['status'] as String? ?? 'Pending';
              FcmService.instance.showLocalNotification(
                title: 'تحديث في حالة الطلب',
                body: 'طلبك رقم ${change.doc.id.substring(0, 8)} أصبح الآن: $status',
              );
            }
          }
        }
      }
      _isFirstOrdersLoad = false;

      final orders = snapshot.docs.map((doc) {
        final data = doc.data();
        return NotificationOrderItem(
          orderId: doc.id,
          status: data['status'] as String? ?? 'pending',
          totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
          itemCount: (data['items'] as List?)?.length ?? 0,
          date: data['date'] as String? ?? '',
          createdAt: data['createdAt'] as Timestamp?,
        );
      }).toList();

      // Sort by createdAt descending
      orders.sort((a, b) {
        if (a.createdAt == null && b.createdAt == null) return 0;
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });

      emit(state.copyWith(
        orders: orders, 
        unreadCount: state.unreadCount + newCount
      ));
      log('[NotificationCubit] Orders updated: ${orders.length}');
    }, onError: (e) => log('[NotificationCubit] Orders error: $e'));

    // Listen to promotions from Firestore
    _promosSub = FirebaseFirestore.instance
        .collection('promotions')
        .snapshots()
        .listen((snapshot) {
      int newCount = 0;
      if (!_isFirstPromosLoad) {
        for (var change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            newCount++;
            final data = change.doc.data();
            if (data != null) {
              final title = data['title'] as String? ?? 'عرض جديد';
              final desc = data['description'] as String? ?? 'تفقد العروض الحصرية الآن!';
              FcmService.instance.showLocalNotification(
                title: title,
                body: desc,
              );
            }
          }
        }
      }
      _isFirstPromosLoad = false;

      final promos = snapshot.docs.map((doc) {
        final data = doc.data();
        return NotificationPromoItem(
          promoId: doc.id,
          title: data['title'] as String? ?? '',
          description: data['description'] as String? ?? '',
          discount: data['discount'] ?? data['discountPercent'] ?? '',
          code: data['code'] as String? ?? '',
        );
      }).toList();

      emit(state.copyWith(
        promos: promos,
        unreadCount: state.unreadCount + newCount
      ));
      log('[NotificationCubit] Promos updated: ${promos.length}');
    }, onError: (e) => log('[NotificationCubit] Promos error: $e'));

    // Listen for chat creation/updates to know the chatId
    _chatSub = FirebaseFirestore.instance
        .collection('chats')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snap) {
      if (snap.docs.isNotEmpty) {
        final chatId = snap.docs.first.id;
        _listenToChatMessages(chatId);
      }
    }, onError: (e) => log('[NotificationCubit] Chat meta error: $e'));
  }

  void _listenToChatMessages(String chatId) {
    _chatMessagesSub?.cancel();
    _chatMessagesSub = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderRole', isEqualTo: 'admin')
        .snapshots()
        .listen((snapshot) {
      int newCount = 0;
      if (!_isFirstChatLoad) {
        for (var change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            newCount++;
            final data = change.doc.data();
            if (data != null) {
              final text = data['text'] as String? ?? 'رسالة جديدة';
              FcmService.instance.showLocalNotification(
                title: 'رسالة من الدعم',
                body: text,
              );
            }
          }
        }
      }
      _isFirstChatLoad = false;

      if (newCount > 0) {
        emit(state.copyWith(unreadCount: state.unreadCount + newCount));
        log('[NotificationCubit] Support messages updated');
      }
    }, onError: (e) => log('[NotificationCubit] Chat messages error: $e'));
  }

  /// Marks all notifications as read (clears the badge count)
  void markAllAsRead() {
    emit(state.copyWith(unreadCount: 0));
  }

  void _stopListening() {
    _ordersSub?.cancel();
    _promosSub?.cancel();
    _chatSub?.cancel();
    _chatMessagesSub?.cancel();
    _ordersSub = null;
    _promosSub = null;
    _chatSub = null;
    _chatMessagesSub = null;
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    _stopListening();
    return super.close();
  }
}