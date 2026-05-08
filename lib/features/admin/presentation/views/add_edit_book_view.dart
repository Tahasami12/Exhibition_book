import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_books_cubit.dart';
import 'package:exhibition_book/features/home/data/models/book_model.dart';
import 'package:exhibition_book/features/home/presentation/cubit/authors_cubit.dart';
import 'package:exhibition_book/features/home/presentation/cubit/authors_state.dart';
import 'package:exhibition_book/features/home/presentation/cubit/vendors_cubit.dart';
import 'package:exhibition_book/features/home/presentation/cubit/vendors_state.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';

class AddEditBookView extends StatefulWidget {
  final BookModel? book;
  const AddEditBookView({super.key, this.book});

  @override
  State<AddEditBookView> createState() => _AddEditBookViewState();
}

class _AddEditBookViewState extends State<AddEditBookView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleArController;
  late TextEditingController _titleEnController;
  late TextEditingController _descriptionArController;
  late TextEditingController _descriptionEnController;
  late TextEditingController _priceController;
  late TextEditingController _ratingController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryArController;
  late TextEditingController _categoryEnController;
  late TextEditingController _stockController;

  String? _selectedAuthorId;
  String? _selectedVendorId;

  @override
  void initState() {
    super.initState();
    _titleArController =
        TextEditingController(text: widget.book?.titleAr ?? '');
    _titleEnController =
        TextEditingController(text: widget.book?.titleEn ?? '');
    _descriptionArController =
        TextEditingController(text: widget.book?.descriptionAr ?? '');
    _descriptionEnController =
        TextEditingController(text: widget.book?.descriptionEn ?? '');
    _priceController =
        TextEditingController(text: widget.book?.price.toString() ?? '0.0');
    _ratingController =
        TextEditingController(text: widget.book?.rating.toString() ?? '5.0');
    _imageUrlController =
        TextEditingController(text: widget.book?.imageUrl ?? '');
    _categoryArController =
        TextEditingController(text: widget.book?.categoryAr ?? '');
    _categoryEnController =
        TextEditingController(text: widget.book?.categoryEn ?? '');
    _stockController =
        TextEditingController(text: widget.book?.stock.toString() ?? '10');

    _selectedAuthorId = widget.book?.authorId;
    _selectedVendorId = widget.book?.vendorId;
  }

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _descriptionArController.dispose();
    _descriptionEnController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _imageUrlController.dispose();
    _categoryArController.dispose();
    _categoryEnController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: widget.book == null ? t.addBook : t.editBook,
        context: context,
      ),
      body: Builder(
        builder: (context) {
          final authorState = context.watch<AuthorsCubit>().state;
          final vendorState = context.watch<VendorsCubit>().state;

          bool isLoading = authorState is AuthorsLoading || vendorState is VendorsLoading;
          bool hasError = authorState is AuthorsError || vendorState is VendorsError;

          if (isLoading) return const Center(child: CircularProgressIndicator());
          if (hasError) {
            return Center(child: Text(t.failedToLoadData));
          }

          List<AuthorModel> authors = [];
          if (authorState is AuthorsLoaded) authors = authorState.authors;

          List<VendorModel> vendors = [];
          if (vendorState is VendorsLoaded) vendors = vendorState.vendors;

          if (authors.isEmpty || vendors.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning, color: Colors.orange, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      authors.isEmpty ? t.noAuthorsFound : t.noVendorsFound,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.mustAddAuthorVendorFirst,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      child: Text(t.goBack),
                    )
                  ],
                ),
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context) ?? 900),
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
                            Expanded(child: _buildTextField(_titleArController, t.bookTitleAr, true, t)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField(_categoryArController, t.categoryArLabel, true, t)),
                          ],
                        )
                      else ...[
                        _buildTextField(_titleArController, t.bookTitleAr, true, t),
                        const SizedBox(height: 12),
                        _buildTextField(_categoryArController, t.categoryArLabel, true, t),
                      ],
                      const SizedBox(height: 12),
                      _buildTextField(_descriptionArController, t.descriptionArLabel, false, t, maxLines: 2),
                      const SizedBox(height: 20),
                      
                      _buildSectionTitle(t.englishInfo),
                      const SizedBox(height: 12),
                      if (isTablet)
                        Row(
                          children: [
                            Expanded(child: _buildTextField(_titleEnController, t.bookTitleEn, true, t)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField(_categoryEnController, t.categoryEnLabel, true, t)),
                          ],
                        )
                      else ...[
                        _buildTextField(_titleEnController, t.bookTitleEn, true, t),
                        const SizedBox(height: 12),
                        _buildTextField(_categoryEnController, t.categoryEnLabel, true, t),
                      ],
                      const SizedBox(height: 12),
                      _buildTextField(_descriptionEnController, t.descriptionEnLabel, false, t, maxLines: 2),
                      const SizedBox(height: 20),
                      
                      _buildSectionTitle(t.generalInfo),
                      const SizedBox(height: 12),
                      if (isTablet)
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                t.author,
                                _selectedAuthorId,
                                authors.map((a) => DropdownMenuItem(value: a.id, child: Text('${a.nameAr} / ${a.nameEn}'))).toList(),
                                (val) => setState(() => _selectedAuthorId = val),
                                t,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                t.vendor,
                                _selectedVendorId,
                                vendors.map((v) => DropdownMenuItem(value: v.id, child: Text('${v.nameAr} / ${v.nameEn}'))).toList(),
                                (val) => setState(() => _selectedVendorId = val),
                                t,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _buildDropdown(
                          t.author,
                          _selectedAuthorId,
                          authors.map((a) => DropdownMenuItem(value: a.id, child: Text('${a.nameAr} / ${a.nameEn}'))).toList(),
                          (val) => setState(() => _selectedAuthorId = val),
                          t,
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          t.vendor,
                          _selectedVendorId,
                          vendors.map((v) => DropdownMenuItem(value: v.id, child: Text('${v.nameAr} / ${v.nameEn}'))).toList(),
                          (val) => setState(() => _selectedVendorId = val),
                          t,
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildTextField(_priceController, t.priceLabel, true, t, keyboardType: TextInputType.number)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTextField(_stockController, t.stock, true, t, keyboardType: TextInputType.number)),
                          if (isTablet) ...[
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField(_ratingController, t.rating, true, t, keyboardType: TextInputType.number)),
                          ],
                        ],
                      ),
                      if (!isTablet) ...[
                        const SizedBox(height: 12),
                        _buildTextField(_ratingController, t.rating, true, t, keyboardType: TextInputType.number),
                      ],
                      const SizedBox(height: 12),
                      _buildTextField(_imageUrlController, t.imageUrlLabel, false, t),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: AdminTheme.primaryButtonStyle(context),
                          onPressed: () => _submit(authors, t),
                          child: Text(widget.book == null ? t.addBook : t.saveChanges),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _buildTextField(TextEditingController controller, String label, bool required, AppStrings t, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: AdminTheme.inputDecoration(label),
      validator: required ? (v) => v == null || v.isEmpty ? t.requiredField : null : null,
    );
  }

  Widget _buildDropdown(String label, String? value, List<DropdownMenuItem<String>> items, ValueChanged<String?> onChanged, AppStrings t) {
    return DropdownButtonFormField<String>(
      decoration: AdminTheme.inputDecoration(label),
      value: value,
      items: items,
      onChanged: onChanged,
      validator: (v) => v == null ? t.requiredField : null,
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }

  void _submit(List<AuthorModel> authors, AppStrings t) {
    if (_formKey.currentState!.validate()) {
      if (_selectedAuthorId == null || _selectedVendorId == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.selectAuthorVendor)));
        return;
      }

      final selectedAuthor = authors.firstWhere((a) => a.id == _selectedAuthorId);

      final newBook = BookModel(
        id: widget.book?.id ?? '',
        titleAr: _titleArController.text,
        titleEn: _titleEnController.text,
        authorAr: selectedAuthor.nameAr,
        authorEn: selectedAuthor.nameEn,
        authorId: _selectedAuthorId,
        vendorId: _selectedVendorId,
        descriptionAr: _descriptionArController.text,
        descriptionEn: _descriptionEnController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        rating: double.tryParse(_ratingController.text) ?? 5.0,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : 'https://via.placeholder.com/150',
        categoryAr: _categoryArController.text,
        categoryEn: _categoryEnController.text,
        stock: int.tryParse(_stockController.text) ?? 0,
        createdAt: widget.book?.createdAt,
      );

      if (widget.book == null) {
        context.read<AdminBooksCubit>().addBook(newBook);
      } else {
        context.read<AdminBooksCubit>().updateBook(newBook);
      }
      context.pop();
    }
  }
}
