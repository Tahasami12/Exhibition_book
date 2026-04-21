import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String bookId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.bookId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      bookId: map['bookId'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: (map['quantity'] ?? 1).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}

class AdminOrderModel {
  final String id;
  final String userId;
  final String userName;
  final String phone;
  final String email;
  final String address;
  final List<OrderItemModel> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final double totalAmount;
  final String status;
  final String date;
  final String? selectedDateTime;
  final String? paymentMethod;

  AdminOrderModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.phone,
    required this.email,
    required this.address,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.date,
    this.selectedDateTime,
    this.paymentMethod,
  });

  factory AdminOrderModel.fromFirestore(Map<String, dynamic> json, String id) {
    // Firestore sometimes returns nested maps as Map<Object?, Object?> — cast safely
    List<OrderItemModel> parsedItems = [];
    try {
      final rawItems = json['items'];
      if (rawItems is List) {
        parsedItems = rawItems.map((e) {
          final itemMap = Map<String, dynamic>.from(e as Map);
          return OrderItemModel.fromMap(itemMap);
        }).toList();
      }
    } catch (_) {
      parsedItems = [];
    }

    return AdminOrderModel(
      id: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Unknown User',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      items: parsedItems,
      subtotal: (json['subtotal'] ?? json['productSubtotal'] ?? 0).toDouble(),
      shipping: (json['shipping'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? json['total'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      date: json['date'] ?? '',
      selectedDateTime: json['selectedDateTime'],
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'phone': phone,
      'email': email,
      'address': address,
      'items': items.map((i) => i.toMap()).toList(),
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'discount': discount,
      'totalAmount': totalAmount,
      'status': status,
      'date': date,
      'selectedDateTime': selectedDateTime,
      'paymentMethod': paymentMethod,
    };
  }
}
