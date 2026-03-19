
import 'package:exhibition_book/features/cart_feature/presentation/views/set_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/responsive.dart';
import '../../data/delivery_address.dart';
import '../view_model/confirm_order_state.dart';
import '../view_model/confirm_order_view_model.dart';
import 'order_recieved_screen.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfirmOrderViewModel(),
      child: const _ConfirmOrderView(),
    );
  }
}

class _ConfirmOrderView extends StatelessWidget {
  const _ConfirmOrderView();

  Future<void> _pickAddress(BuildContext context) async {
    final viewModel = context.read<ConfirmOrderViewModel>();
    final DeliveryAddress? address = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetLocationScreen(),
      ),
    );

    if (address != null) {
      viewModel.updateAddress(address);
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C47FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null || !context.mounted) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C47FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null || !context.mounted) return;

    final combined = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    context.read<ConfirmOrderViewModel>().setDateTime(combined);
  }

  String _formatDateTime(DateTime? dateTime, BuildContext context) {
    if (dateTime == null) {
      return 'Choose date and time';
    }
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime);
  }

  void _handleMessages(BuildContext context, ConfirmOrderState state) {
    if (state.message == 'address_missing') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please set your address before proceeding',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmOrderViewModel, ConfirmOrderState>(
      listener: (context, state) {
        _handleMessages(context, state);
        if (state.shouldNavigate) {
          context.read<ConfirmOrderViewModel>().acknowledgeNavigation();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const OrderReceivedScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final address = state.address;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: Responsive.responsiveIconSize(context, 24),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
                'Order Details',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.responsiveFontSize(context, 18),
              ),
            ),
            centerTitle: true,
            actions: const [
              // LanguageToggleButton(),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = Responsive.maxContentWidth(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? double.infinity,
                  ),
                  child: SingleChildScrollView(
                    padding: Responsive.responsivePadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AddressCard(
                          address: address,
                          onChange: () => _pickAddress(context),
                        ),
                        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                        _SummaryCard(state: state),
                        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                        GestureDetector(
                          onTap: () => _selectDateTime(context),
                          child: _DateTimePickerTile(
                            label: 'Date & time',
                            value: _formatDateTime(state.selectedDateTime, context),
                            isSelected: state.selectedDateTime != null,
                          ),
                        ),
                        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: context.read<ConfirmOrderViewModel>().proceed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C47FF),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.responsiveSpacing(context, 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(context, 12),
                                ),
                              ),
                            ),
                            child: Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: Responsive.responsiveFontSize(context, 16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.onChange,
  });

  final DeliveryAddress address;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 8)),
            decoration: BoxDecoration(
              color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                Responsive.responsiveBorderRadius(context, 8),
              ),
            ),
            child: Icon(
              Icons.location_on,
              color: const Color(0xFF6C47FF),
              size: Responsive.responsiveIconSize(context, 20),
            ),
          ),
          SizedBox(width: Responsive.responsiveSpacing(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.displayTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.responsiveFontSize(context, 16),
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 4)),
                Text(
                  address.fullAddress,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Responsive.responsiveFontSize(context, 14),
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                TextButton(
                  onPressed: onChange,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Change',
                    style: TextStyle(
                      color: const Color(0xFF6C47FF),
                      fontSize: Responsive.responsiveFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: Responsive.responsiveIconSize(context, 16),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.state});

  final ConfirmOrderState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.responsiveFontSize(context, 16),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
          _summaryRow(context, 'Price', '\$${state.productSubtotal.toStringAsFixed(2)}'),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          _summaryRow(context, 'Shipping', '\$${state.shipping.toStringAsFixed(2)}'),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          _summaryRow(context, '${'Tax'} (5%)', '\$${state.tax.toStringAsFixed(2)}'),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          _summaryRow(context, 'Discount', '-\$${state.discount.toStringAsFixed(2)}', valueColor: Colors.green),
          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
          const Divider(),
          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
          _summaryRow(
            context,
            'Total Payment',
            '\$${state.total.toStringAsFixed(2)}',
            isBold: true,
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => _OrderDetailsSheet(state: state),
              );
            },
            borderRadius: BorderRadius.circular(
              Responsive.responsiveBorderRadius(context, 6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'See details',
                  style: TextStyle(
                    color: const Color(0xFF6C47FF),
                    fontSize: Responsive.responsiveFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: Responsive.responsiveSpacing(context, 4)),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF6C47FF),
                  size: Responsive.responsiveIconSize(context, 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value, {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: isBold ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
              fontSize: Responsive.responsiveFontSize(context, isBold ? 16 : 14),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: Responsive.responsiveFontSize(context, isBold ? 16 : 14),
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _OrderDetailsSheet extends StatelessWidget {
  const _OrderDetailsSheet({required this.state});

  final ConfirmOrderState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.responsivePadding(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: Responsive.responsiveSpacing(context, 40),
              height: 4,
              margin: EdgeInsets.only(
                bottom: Responsive.responsiveSpacing(context, 12),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Order Details',
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 16)),
          _summaryRow(context, 'Product Subtotal', state.productSubtotal),
          _summaryRow(context, 'Shipping', state.shipping),
          _summaryRow(context, '${'Tax'} (5%)', state.tax),
          _summaryRow(context, 'Discount', -state.discount),
          const Divider(),
          _summaryRow(context, 'Total Payment', state.total, isBold: true),
          SizedBox(height: Responsive.responsiveSpacing(context, 20)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C47FF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.responsiveSpacing(context, 12),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Responsive.responsiveBorderRadius(context, 8),
                  ),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, double value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.responsiveSpacing(context, 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            (value >= 0 ? '\$' : '-\$') + value.abs().toStringAsFixed(2),
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 14),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: value < 0 ? Colors.green : Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimePickerTile extends StatelessWidget {
  const _DateTimePickerTile({
    required this.label,
    required this.value,
    required this.isSelected,
  });

  final String label;
  final String value;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 8)),
            decoration: BoxDecoration(
              color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                Responsive.responsiveBorderRadius(context, 8),
              ),
            ),
            child: Icon(
              Icons.calendar_month,
              color: const Color(0xFF6C47FF),
              size: Responsive.responsiveIconSize(context, 20),
            ),
          ),
          SizedBox(width: Responsive.responsiveSpacing(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Responsive.responsiveFontSize(context, 16),
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF6C47FF) : Colors.grey,
                    fontSize: Responsive.responsiveFontSize(context, 14),
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: Responsive.responsiveIconSize(context, 16),
          ),
        ],
      ),
    );
  }
}
