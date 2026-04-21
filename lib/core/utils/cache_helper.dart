import 'package:hive_flutter/hive_flutter.dart';

class CacheHelper {
  static const String _userBoxName = 'user_box';
  static const String _uidKey = 'uid';
  static const String _roleKey = 'role';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBoxName);
  }

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
