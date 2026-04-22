import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';
import '../cubit/confirm_order_cubit.dart';
import '../cubit/confirm_order_state.dart';

// ─────────────────────────────────────────────────────────────────────────────
/// Entry point — provides local Cubits that are scoped to this flow only.
// ─────────────────────────────────────────────────────────────────────────────
class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartTotal = context.read<CartCubit>().state.total;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConfirmOrderCubit(cartSubtotal: cartTotal),
        ),
        BlocProvider(
          create: (_) => CheckoutCubit(),
        ),
      ],
      child: const _ConfirmOrderView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
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

  // ─── Submit ─────────────────────────────────────────────────────────────────
  void _onCheckout() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cartCubit = context.read<CartCubit>();
    final confirmCubit = context.read<ConfirmOrderCubit>();
    final checkoutCubit = context.read<CheckoutCubit>();

    // Build the items list as plain Maps — matches Firestore and AdminOrderModel
    final cartItems = cartCubit.state.items.map((item) => {
      'bookId': item.id,
      'title': item.title,
      'imageUrl': item.imageUrl,
      'price': item.price,
      'quantity': item.quantity,
    }).toList();

    final s = confirmCubit.state;

    checkoutCubit.placeOrder(
      customerName: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      cartItems: cartItems,
      subtotal: s.productSubtotal,
      shipping: s.shipping,
      tax: s.tax,
      discount: s.discount,
      total: s.total,
    );
  }

  // ─── Success dialog ──────────────────────────────────────────────────────────
  void _showSuccessDialog() {
    final t = AppStrings.read(context);
    // Capture references BEFORE entering builder — avoids stale context crash
    final cartCubit = context.read<CartCubit>();
    final router = GoRouter.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6C47FF).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF6C47FF), size: 56),
            ),
            const SizedBox(height: 20),
            Text(
              t.orderSuccess,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C47FF),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              t.orderSuccessSub,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogCtx).pop(); // close dialog with its own ctx
                  cartCubit.clearCart();          // pre-captured reference
                  router.go('/home');             // GoRouter-safe navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C47FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t.returnToHome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (ctx, state) {
        if (state is CheckoutSuccess) {
          _showSuccessDialog();
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<ConfirmOrderCubit, ConfirmOrderState>(
        builder: (ctx, confirmState) {
          final t = AppStrings.of(ctx);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(ctx),
              ),
              title: Text(
                t.orderDetails,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.responsiveFontSize(ctx, 18),
                ),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: Responsive.responsivePadding(ctx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Customer info ─────────────────────────────────────
                    _SectionCard(
                      title: t.customerInfo,
                      icon: Icons.person_outline,
                      child: Column(
                        children: [
                          _buildField(
                            context: ctx,
                            controller: _nameCtrl,
                            label: t.fullName,
                            hint: t.nameExample,
                            icon: Icons.person,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? t.nameRequired
                                : null,
                          ),
                          const SizedBox(height: 14),
                          _buildField(
                            context: ctx,
                            controller: _phoneCtrl,
                            label: t.phoneNumber,
                            hint: t.phoneExample,
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return t.phoneRequired;
                              }
                              if (v.trim().length < 8) return t.phoneInvalid;
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          _buildField(
                            context: ctx,
                            controller: _addressCtrl,
                            label: t.fullAddress,
                            hint: t.addressExample,
                            icon: Icons.location_on,
                            maxLines: 2,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? t.addressRequired
                                : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(ctx, 16)),

                    // ── Order summary ─────────────────────────────────────
                    _SectionCard(
                      title: t.orderSummary,
                      icon: Icons.receipt_long_outlined,
                      child: _SummaryBody(state: confirmState),
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(ctx, 24)),

                    // ── Submit button ─────────────────────────────────────
                    BlocBuilder<CheckoutCubit, CheckoutState>(
                      builder: (ctx2, checkoutState) {
                        final isLoading = checkoutState is CheckoutLoading;
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _onCheckout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C47FF),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.responsiveSpacing(
                                    ctx, 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(ctx, 12),
                                ),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    t.confirmOrderBtn,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(
                                          ctx, 16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: Responsive.responsiveSpacing(ctx, 32)),
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
    required BuildContext context,
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
          borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
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
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
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

// ─────────────────────────────────────────────────────────────────────────────
class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.state});
  final ConfirmOrderState state;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Column(
      children: [
        _row(t.subtotal,
            'EGP ${state.productSubtotal.toStringAsFixed(2)}'),
        _row(t.shipping, 'EGP ${state.shipping.toStringAsFixed(2)}'),
        _row(t.taxWithPercent, 'EGP ${state.tax.toStringAsFixed(2)}'),
        _row(t.discount, '-EGP ${state.discount.toStringAsFixed(2)}',
            valueColor: Colors.green),
        const Divider(height: 20),
        _row(t.total, 'EGP ${state.total.toStringAsFixed(2)}',
            isBold: true),
      ],
    );
  }

  Widget _row(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isBold ? null : Colors.grey,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
          Text(value,
              style: TextStyle(
                  color: valueColor,
                  fontWeight:
                      isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14)),
        ],
      ),
    );
  }
}
