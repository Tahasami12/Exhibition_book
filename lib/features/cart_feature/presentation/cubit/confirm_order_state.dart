/// Holds only the pricing breakdown for the order summary.
class ConfirmOrderState {
  final double productSubtotal;
  final double shipping;
  final double tax;
  final double discount;

  const ConfirmOrderState({
    this.productSubtotal = 0.0,
    this.shipping = 2.0,
    this.tax = 0.0,
    this.discount = 0.0,
  });

  double get total => productSubtotal + shipping + tax - discount;

  ConfirmOrderState copyWith({
    double? productSubtotal,
    double? shipping,
    double? tax,
    double? discount,
  }) {
    return ConfirmOrderState(
      productSubtotal: productSubtotal ?? this.productSubtotal,
      shipping: shipping ?? this.shipping,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
    );
  }
}
