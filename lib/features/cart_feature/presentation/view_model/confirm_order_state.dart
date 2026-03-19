
import '../../../../core/base/view_state.dart';
import '../../data/delivery_address.dart';

class ConfirmOrderState {
  final ViewStatus status;
  final DeliveryAddress address;
  final DateTime? selectedDateTime;
  final double productSubtotal;
  final double shipping;
  final double tax;
  final double discount;
  final bool shouldNavigate;
  final String? message;

  const ConfirmOrderState({
    this.status = ViewStatus.idle,
    required this.address,
    this.selectedDateTime,
    this.productSubtotal = 85.0,
    this.shipping = 2.0,
    this.tax = 4.25,
    this.discount = 2.15,
    this.shouldNavigate = false,
    this.message,
  });

  double get total => productSubtotal + shipping + tax - discount;

  ConfirmOrderState copyWith({
    ViewStatus? status,
    DeliveryAddress? address,
    DateTime? selectedDateTime,
    double? productSubtotal,
    double? shipping,
    double? tax,
    double? discount,
    bool? shouldNavigate,
    String? message,
    bool resetMessage = false,
  }) {
    return ConfirmOrderState(
      status: status ?? this.status,
      address: address ?? this.address,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      productSubtotal: productSubtotal ?? this.productSubtotal,
      shipping: shipping ?? this.shipping,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      message: resetMessage ? null : message ?? this.message,
    );
  }
}
