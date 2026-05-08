import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_promotions_cubit.dart';
import 'package:exhibition_book/features/home/data/models/promotion_model.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';

class AddEditPromotionView extends StatefulWidget {
  final PromotionModel? promotion;
  const AddEditPromotionView({super.key, this.promotion});

  @override
  State<AddEditPromotionView> createState() => _AddEditPromotionViewState();
}

class _AddEditPromotionViewState extends State<AddEditPromotionView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleArController;
  late TextEditingController _titleEnController;
  late TextEditingController _discountArController;
  late TextEditingController _discountEnController;
  late TextEditingController _imageUrlController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _titleArController =
        TextEditingController(text: widget.promotion?.titleAr ?? '');
    _titleEnController =
        TextEditingController(text: widget.promotion?.titleEn ?? '');
    _discountArController =
        TextEditingController(text: widget.promotion?.discountAr ?? '');
    _discountEnController =
        TextEditingController(text: widget.promotion?.discountEn ?? '');
    _imageUrlController =
        TextEditingController(text: widget.promotion?.imageUrl ?? '');
    _isActive = widget.promotion?.isActive ?? true;
  }

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _discountArController.dispose();
    _discountEnController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit(AppStrings t) {
    if (_formKey.currentState!.validate()) {
      final newPromo = PromotionModel(
        id: widget.promotion?.id ?? '',
        titleAr: _titleArController.text,
        titleEn: _titleEnController.text,
        discountAr: _discountArController.text,
        discountEn: _discountEnController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : 'https://via.placeholder.com/150',
        isActive: _isActive,
      );

      if (widget.promotion == null) {
        context.read<AdminPromotionsCubit>().addPromotion(newPromo);
      } else {
        context.read<AdminPromotionsCubit>().updatePromotion(newPromo);
      }

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
        title: widget.promotion == null ? t.addPromotion : t.editPromotion,
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
                  if (isTablet)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_titleArController, t.bookTitleAr, t.requiredField)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(_discountArController, t.discountArLabel, t.requiredField)),
                      ],
                    )
                  else ...[
                    _buildTextField(_titleArController, t.bookTitleAr, t.requiredField),
                    const SizedBox(height: 12),
                    _buildTextField(_discountArController, t.discountArLabel, t.requiredField),
                  ],
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle(t.englishInfo),
                  const SizedBox(height: 12),
                  if (isTablet)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_titleEnController, t.bookTitleEn, t.requiredField)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(_discountEnController, t.discountEnLabel, t.requiredField)),
                      ],
                    )
                  else ...[
                    _buildTextField(_titleEnController, t.bookTitleEn, t.requiredField),
                    const SizedBox(height: 12),
                    _buildTextField(_discountEnController, t.discountEnLabel, t.requiredField),
                  ],
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle(t.generalInfo),
                  const SizedBox(height: 12),
                  _buildTextField(_imageUrlController, t.imageUrlLabel, null),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(t.activePromotion, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    subtitle: Text(t.promoVisibilityHint, style: const TextStyle(fontSize: 12)),
                    value: _isActive,
                    onChanged: (val) => setState(() => _isActive = val),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: AdminTheme.primaryButtonStyle(context),
                      onPressed: () => _submit(t),
                      child: Text(widget.promotion == null ? t.addPromotion : t.saveChanges),
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

  Widget _buildTextField(TextEditingController controller, String label, String? errorMsg) {
    return TextFormField(
      controller: controller,
      decoration: AdminTheme.inputDecoration(label),
      validator: errorMsg != null ? (v) => v == null || v.isEmpty ? errorMsg : null : null,
    );
  }
}
