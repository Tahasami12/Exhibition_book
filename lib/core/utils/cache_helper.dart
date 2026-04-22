import 'package:hive_flutter/hive_flutter.dart';
import 'package:exhibition_book/features/cart_feature/data/cart_item.dart';

class CacheHelper {
  static const String _userBoxName = 'user_box';
  static const String _uidKey = 'uid';
  static const String _roleKey = 'role';
  static const String _onboardingKey = 'onboarding_seen';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBoxName);
  }

  // ── Onboarding ──────────────────────────────────────────────────────────────
  static bool isOnboardingSeen() {
    return Hive.box(_userBoxName).get(_onboardingKey, defaultValue: false) as bool;
  }

  static Future<void> setOnboardingSeen() async {
    await Hive.box(_userBoxName).put(_onboardingKey, true);
  }

  // ── Cart ────────────────────────────────────────────────────────────────────
  static const String _cartKey = 'cart_items';

  static List<CartItem> getCartItems() {
    var box = Hive.box(_userBoxName);
    var list = box.get(_cartKey, defaultValue: []);
    if (list is List) {
      return list.map((e) => CartItem.fromJson(Map<dynamic, dynamic>.from(e as Map))).toList();
    }
    return [];
  }

  static Future<void> saveCartItems(List<CartItem> items) async {
    var box = Hive.box(_userBoxName);
    List<Map<String, dynamic>> jsonList = items.map((e) => e.toJson()).toList();
    await box.put(_cartKey, jsonList);
  }

  // ── User Data ──────────────────────────────────────────────────────────────
  static Future<void> saveUserData({required String uid, required String role}) async {
    var box = Hive.box(_userBoxName);
    await box.put(_uidKey, uid);
    await box.put(_roleKey, role);
  }

  static String? getUid() {
    var box = Hive.box(_userBoxName);
    return box.get(_uidKey);
  }

  static String? getRole() {
    var box = Hive.box(_userBoxName);
    return box.get(_roleKey);
  }

  static Future<void> clearData() async {
    var box = Hive.box(_userBoxName);
    await box.clear();
  }
}
