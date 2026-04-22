import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/responsive.dart';
import '../../../cart_feature/presentation/views/set_location_screen.dart';
import '../../data/cart_item.dart';
import '../../data/delivery_address.dart';
import '../../data/order_repository.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';
import '../cubit/confirm_order_cubit.dart';
import '../cubit/confirm_order_state.dart';

/// Main entry point – injects CheckoutCubit.
class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartTotal = context.read<CartCubit>().state.total;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                ConfirmOrderCubit(cartSubtotal: cartTotal)),
        BlocProvider(
          create: (_) => CheckoutCubit(OrderRepository()),
        ),
      ],
      child: const _ConfirmOrderView(),
    );
  }
}

class _ConfirmOrderView extends StatefulWidget {
  const _ConfirmOrderView();

  @override
  State<_ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<_ConfirmOrderView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  // ─── Address from map ──────────────────────────────────────────────────────
  Future<void> _pickAddress(BuildContext context) async {
    final DeliveryAddress? address = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SetLocationScreen()),
    );
    if (address != null && mounted) {
      context.read<ConfirmOrderCubit>().updateAddress(address);
      _addressCtrl.text = address.fullAddress;
    }
  }

  // ─── Date & time ──────────────────────────────────────────────────────────
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF6C47FF),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      ),
    );
    if (selectedDate == null || !context.mounted) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF6C47FF),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      ),
    );
    if (selectedTime == null || !context.mounted) return;

    final combined = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    context.read<ConfirmOrderCubit>().setDateTime(combined);
  }

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return 'اختر التاريخ والوقت';
    return DateFormat('MMM d, yyyy - h:mm a').format(dt);
  }

  // ─── Checkout press ────────────────────────────────────────────────────────
  void _onCheckout(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cartState = context.read<CartCubit>().state;
    final confirmState = context.read<ConfirmOrderCubit>().state;

    context.read<CheckoutCubit>().placeOrder(
          customerName: _nameCtrl.text,
          phone: _phoneCtrl.text,
          address: _addressCtrl.text,
          cartItems: cartState.items,
          subtotal: confirmState.productSubtotal,
          shipping: confirmState.shipping,
          tax: confirmState.tax,
          discount: confirmState.discount,
          total: confirmState.total,
          selectedDateTime: confirmState.selectedDateTime?.toIso8601String(),
        );
  }

  // ─── Success dialog ────────────────────────────────────────────────────────
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF6C47FF), size: 56),
            ),
            const SizedBox(height: 20),
            const Text(
              'تم تأكيد الطلب بنجاح',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C47FF),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'وسيتم التواصل مع حضرتك من خلال خدمة العملاء.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // close dialog
                  context.read<CartCubit>().clearCart();
                  // pop back to cart / home
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C47FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('العودة للرئيسية',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          _showSuccessDialog(context);
        } else if (state is CheckoutValidationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message,
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ));
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(state.message, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
      child: BlocBuilder<ConfirmOrderCubit, ConfirmOrderState>(
        builder: (context, confirmState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'تفاصيل الطلب',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.responsiveFontSize(context, 18),
                ),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: Responsive.responsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Customer info card ─────────────────────────────────
                    _SectionCard(
                      title: 'معلومات العميل',
                      icon: Icons.person_outline,
                      child: Column(
                        children: [
                          _buildField(
                            controller: _nameCtrl,
                            label: 'الاسم الكامل',
                            hint: 'مثال: محمد أحمد',
                            icon: Icons.person,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'من فضلك أدخل اسمك'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          _buildField(
                            controller: _phoneCtrl,
                            label: 'رقم الهاتف',
                            hint: 'مثال: 0501234567',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'من فضلك أدخل رقم هاتفك';
                              }
                              if (v.trim().length < 8) {
                                return 'رقم الهاتف غير صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildField(
                            controller: _addressCtrl,
                            label: 'العنوان الكامل',
                            hint: 'المدينة، الشارع، رقم المبنى',
                            icon: Icons.location_on,
                            maxLines: 2,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'من فضلك أدخل عنوانك'
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: () => _pickAddress(context),
                              icon: const Icon(Icons.map_outlined,
                                  color: Color(0xFF6C47FF)),
                              label: const Text('اختيار من الخريطة',
                                  style:
                                      TextStyle(color: Color(0xFF6C47FF))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(context, 16)),

                    // ─── Order summary ──────────────────────────────────────
                    _SectionCard(
                      title: 'ملخص الطلب',
                      icon: Icons.receipt_long_outlined,
                      child: _SummaryBody(state: confirmState),
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(context, 16)),

                    // ─── Date/time ──────────────────────────────────────────
                    GestureDetector(
                      onTap: () => _selectDateTime(context),
                      child: _SectionCard(
                        title: 'التاريخ والوقت',
                        icon: Icons.calendar_month,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatDateTime(confirmState.selectedDateTime),
                                style: TextStyle(
                                  color: confirmState.selectedDateTime != null
                                      ? const Color(0xFF6C47FF)
                                      : Colors.grey,
                                  fontSize: Responsive.responsiveFontSize(
                                      context, 14),
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey, size: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(context, 24)),

                    // ─── Submit button ──────────────────────────────────────
                    BlocBuilder<CheckoutCubit, CheckoutState>(
                      builder: (context, checkoutState) {
                        final isLoading = checkoutState is CheckoutLoading;
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                isLoading ? null : () => _onCheckout(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C47FF),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    Responsive.responsiveSpacing(context, 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(
                                      context, 12),
                                ),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2.5))
                                : Text(
                                    'تأكيد الطلب',
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(
                                          context, 16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(context, 32)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF6C47FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF6C47FF), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// ─── Reusable section card ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF6C47FF), size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ─── Order summary body ───────────────────────────────────────────────────────

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.state});
  final ConfirmOrderState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row(context, 'المجموع الجزئي',
            '\$${state.productSubtotal.toStringAsFixed(2)}'),
        _row(context, 'الشحن', '\$${state.shipping.toStringAsFixed(2)}'),
        _row(context, 'الضريبة (5%)', '\$${state.tax.toStringAsFixed(2)}'),
        _row(context, 'الخصم', '-\$${state.discount.toStringAsFixed(2)}',
            valueColor: Colors.green),
        const Divider(height: 20),
        _row(context, 'الإجمالي', '\$${state.total.toStringAsFixed(2)}',
            isBold: true),
      ],
    );
  }

  Widget _row(BuildContext context, String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isBold ? null : Colors.grey,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
        ],
      ),
    );
  }
}
