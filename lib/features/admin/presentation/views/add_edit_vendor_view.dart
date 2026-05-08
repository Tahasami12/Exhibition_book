import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_vendors_cubit.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'package:exhibition_book/features/home/presentation/cubit/vendors_cubit.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';

class AddEditVendorView extends StatefulWidget {
  final VendorModel? vendor;
  const AddEditVendorView({super.key, this.vendor});

  @override
  State<AddEditVendorView> createState() => _AddEditVendorViewState();
}

class _AddEditVendorViewState extends State<AddEditVendorView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameArController;
  late TextEditingController _nameEnController;
  late TextEditingController _logoUrlController;
  late TextEditingController _ratingController;
  bool _isBestVendor = false;

  @override
  void initState() {
    super.initState();
    _nameArController =
        TextEditingController(text: widget.vendor?.nameAr ?? '');
    _nameEnController =
        TextEditingController(text: widget.vendor?.nameEn ?? '');
    _logoUrlController =
        TextEditingController(text: widget.vendor?.logoUrl ?? '');
    _ratingController =
        TextEditingController(text: widget.vendor?.rating.toString() ?? '5.0');
    _isBestVendor = widget.vendor?.isBestVendor ?? false;
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _logoUrlController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _submit(AppStrings t) {
    if (_formKey.currentState!.validate()) {
      final newVendor = VendorModel(
        id: widget.vendor?.id ?? '',
        nameAr: _nameArController.text,
        nameEn: _nameEnController.text,
        logoUrl: _logoUrlController.text.isNotEmpty
            ? _logoUrlController.text
            : 'https://via.placeholder.com/150',
        rating: double.tryParse(_ratingController.text) ?? 5.0,
        isBestVendor: _isBestVendor,
      );

      if (widget.vendor == null) {
        context.read<AdminVendorsCubit>().addVendor(newVendor);
      } else {
        context.read<AdminVendorsCubit>().updateVendor(newVendor);
      }

      context.read<VendorsCubit>().fetchVendors();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: widget.vendor == null ? t.addVendor : t.editVendor,
        context: context,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context) ?? 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(t.arabicInfo),
                  const SizedBox(height: 12),
                  _buildTextField(_nameArController, t.nameArLabel, t.requiredField),
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle(t.englishInfo),
                  const SizedBox(height: 12),
                  _buildTextField(_nameEnController, t.nameEnLabel, t.requiredField),
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle(t.generalInfo),
                  const SizedBox(height: 12),
                  if (isTablet)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_logoUrlController, t.imageUrlLabel, null)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(_ratingController, t.rating, t.requiredField, isNumber: true)),
                      ],
                    )
                  else ...[
                    _buildTextField(_logoUrlController, t.imageUrlLabel, null),
                    const SizedBox(height: 12),
                    _buildTextField(_ratingController, t.rating, t.requiredField, isNumber: true),
                  ],
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: Text(t.bestVendorLabel, style: const TextStyle(fontSize: 14)),
                    value: _isBestVendor,
                    onChanged: (val) => setState(() => _isBestVendor = val),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: AdminTheme.primaryButtonStyle(context),
                      onPressed: () => _submit(t),
                      child: Text(widget.vendor == null ? t.addVendor : t.saveChanges),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _buildTextField(TextEditingController controller, String label, String? errorMsg, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: AdminTheme.inputDecoration(label),
      validator: errorMsg != null ? (v) => v == null || v.isEmpty ? errorMsg : null : null,
    );
  }
}
