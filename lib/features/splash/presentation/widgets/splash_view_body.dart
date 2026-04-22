import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';
import 'package:exhibition_book/core/utils/app_router.dart';
import 'package:exhibition_book/core/utils/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplasViewBody extends StatefulWidget {
  const SplasViewBody({super.key});

  @override
  State<SplasViewBody> createState() => _SplasViewBodyState();
}

class _SplasViewBodyState extends State<SplasViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();

    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _handleNavigation();
      }
    });
  }

  Future<void> _handleNavigation() async {
    // Firebase Auth يحفظ الجلسة تلقائياً — هو المصدر الأساسي
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      // المستخدم مسجل دخوله — نجيب الـ Role
      String? role = CacheHelper.getRole(); // من الكاش أولاً (سريع)

      if (role == null) {
        // لو الكاش فاضي: نجيب الـ Role من Firestore ونحفظه
        try {
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .get();
          role = doc.exists ? (doc.get('role') as String?) ?? 'user' : 'user';
          await CacheHelper.saveUserData(uid: firebaseUser.uid, role: role);
        } catch (_) {
          role = 'user'; // في حالة فشل الاتصال
        }
      }

      if (!mounted) return;

      if (role == 'admin') {
        context.go('/admin');
      } else {
        context.go(AppRouter.kHome);
      }
    } else {
      // No logged-in user — clear any stale cache
      await CacheHelper.clearData();
      if (!mounted) return;
      // If onboarding was already seen, go directly to login
      if (CacheHelper.isOnboardingSeen()) {
        context.go('/login');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: slidingAnimation,
            child: Image.asset(
              AssetData.logo,
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
