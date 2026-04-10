import 'package:flutter/foundation.dart';
import '../../../../core/base/view_state.dart';
import '../../data/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItem> _items = [];
  ViewStatus _status = ViewStatus.idle;
  String? _message;
  bool _shouldNavigateToConfirm = false;

  List<CartItem> get items => _items;
  ViewStatus get status => _status;
  String? get message => _message;
  bool get shouldNavigateToConfirm => _shouldNavigateToConfirm;

  double get total => _items.fold<double>(0, (sum, item) => sum + item.total);
  bool get isEmpty => _items.isEmpty;

  void addItem(CartItem item) {
    print("DEBUG: addToCart triggered for item: ${item.title}");
    final existingIndex = _items.indexWhere((value) => value.id == item.id);
    if (existingIndex != -1) {
      final existing = _items[existingIndex];
      _items[existingIndex] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }

    _status = ViewStatus.success;
    _shouldNavigateToConfirm = false;
    _message = null;
    notifyListeners();
  }

  void increaseQuantity(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        _items[i] = _items[i].copyWith(quantity: _items[i].quantity + 1);
        break;
      }
    }
    _status = ViewStatus.success;
    _shouldNavigateToConfirm = false;
    _message = null;
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        final newQty = _items[i].quantity - 1;
        if (newQty > 0) {
          _items[i] = _items[i].copyWith(quantity: newQty);
        } else {
          _items.removeAt(i);
          _message = 'removed';
        }
        break;
      }
    }
    _status = ViewStatus.success;
    _shouldNavigateToConfirm = false;
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _status = ViewStatus.success;
    _message = 'removed';
    _shouldNavigateToConfirm = false;
    notifyListeners();
  }

  void checkout() {
    if (_items.isEmpty) {
      _status = ViewStatus.failure;
      _message = 'empty';
      _shouldNavigateToConfirm = false;
      notifyListeners();
      return;
    }
    _status = ViewStatus.success;
    _shouldNavigateToConfirm = true;
    _message = null;
    notifyListeners();
  }

  void acknowledgeNavigation() {
    _shouldNavigateToConfirm = false;
    // Don't notify listeners here unless necessary to prevent rebuild loops
  }

  void clearMessage() {
    _message = null;
  }
}
