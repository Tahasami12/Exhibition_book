import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_authors_cubit.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'package:exhibition_book/features/home/presentation/cubit/authors_cubit.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';

class AddEditAuthorView extends StatefulWidget {
  final AuthorModel? author;
  const AddEditAuthorView({super.key, this.author});

  @override
  State<AddEditAuthorView> createState() => _AddEditAuthorViewState();
}

class _AddEditAuthorViewState extends State<AddEditAuthorView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameArController;
  late TextEditingController _nameEnController;
  late TextEditingController _bioArController;
  late TextEditingController _bioEnController;
  late TextEditingController _imageUrlController;
  late TextEditingController _booksCountController;

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(text: widget.author?.nameAr ?? '');
    _nameEnController = TextEditingController(text: widget.author?.nameEn ?? '');
    _bioArController = TextEditingController(text: widget.author?.bioAr ?? '');
    _bioEnController = TextEditingController(text: widget.author?.bioEn ?? '');
    _imageUrlController =
        TextEditingController(text: widget.author?.imageUrl ?? '');
    _booksCountController = TextEditingController(
        text: widget.author?.booksCount.toString() ?? '0');
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _bioArController.dispose();
    _bioEnController.dispose();
    _imageUrlController.dispose();
    _booksCountController.dispose();
    super.dispose();
  }

  void _submit(AppStrings t) {
    if (_formKey.currentState!.validate()) {
      final newAuthor = AuthorModel(
        id: widget.author?.id ?? '',
        nameAr: _nameArController.text,
        nameEn: _nameEnController.text,
        bioAr: _bioArController.text,
        bioEn: _bioEnController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : 'https://via.placeholder.com/150',
        booksCount: int.tryParse(_booksCountController.text) ?? 0,
      );

      if (widget.author == null) {
        context.read<AdminAuthorsCubit>().addAuthor(newAuthor);
      } else {
        context.read<AdminAuthorsCubit>().updateAuthor(newAuthor);
      }

      context.read<AuthorsCubit>().fetchAuthors();
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
        title: widget.author == null ? t.addAuthor : t.editAuthor,
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
                         Expanded(child: _buildTextField(_nameArController, t.nameArLabel, t.requiredField)),
                         const SizedBox(width: 16),
                         Expanded(child: _buildTextField(_bioArController, t.bioArLabel, null, maxLines: 2)),
                       ],
                     )
                  else ...[
                    _buildTextField(_nameArController, t.nameArLabel, t.requiredField),
                    const SizedBox(height: 12),
                    _buildTextField(_bioArController, t.bioArLabel, null, maxLines: 2),
                  ],
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle(t.englishInfo),
                  const SizedBox(height: 12),
                  if (isTablet)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_nameEnController, t.nameEnLabel, t.requiredField)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(_bioEnController, t.bioEnLabel, null, maxLines: 2)),
                      ],
                    )
                  else ...[
                    _buildTextField(_nameEnController, t.nameEnLabel, t.requiredField),
                    const SizedBox(height: 12),
                    _buildTextField(_bioEnController, t.bioEnLabel, null, maxLines: 2),
                  ],
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle(t.generalInfo),
                  const SizedBox(height: 12),
                  if (isTablet)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_imageUrlController, t.imageUrlLabel, null)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(_booksCountController, t.booksCount, t.requiredField, isNumber: true)),
                      ],
                    )
                  else ...[
                    _buildTextField(_imageUrlController, t.imageUrlLabel, null),
                    const SizedBox(height: 12),
                    _buildTextField(_booksCountController, t.booksCount, t.requiredField, isNumber: true),
                  ],
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: AdminTheme.primaryButtonStyle(context),
                      onPressed: () => _submit(t),
                      child: Text(widget.author == null ? t.addAuthor : t.saveChanges),
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

  Widget _buildTextField(TextEditingController controller, String label, String? errorMsg, {int maxLines = 1, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: AdminTheme.inputDecoration(label),
      validator: errorMsg != null ? (v) => v == null || v.isEmpty ? errorMsg : null : null,
    );
  }
}
