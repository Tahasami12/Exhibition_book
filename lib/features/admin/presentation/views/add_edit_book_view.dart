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

class AddEditBookView extends StatefulWidget {
  final BookModel? book;
  const AddEditBookView({super.key, this.book});

  @override
  State<AddEditBookView> createState() => _AddEditBookViewState();
}

class _AddEditBookViewState extends State<AddEditBookView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _ratingController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryController;
  late TextEditingController _stockController;

  String? _selectedAuthorId;
  String? _selectedVendorId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _descriptionController = TextEditingController(text: widget.book?.description ?? '');
    _priceController = TextEditingController(text: widget.book?.price.toString() ?? '0.0');
    _ratingController = TextEditingController(text: widget.book?.rating.toString() ?? '5.0');
    _imageUrlController = TextEditingController(text: widget.book?.imageUrl ?? '');
    _categoryController = TextEditingController(text: widget.book?.category ?? 'Fantasy');
    _stockController = TextEditingController(text: widget.book?.stock.toString() ?? '10');

    _selectedAuthorId = widget.book?.authorId;
    _selectedVendorId = widget.book?.vendorId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _ratingController.dispose();
    _imageUrlController.dispose();
    _categoryController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit(List<AuthorModel> authors) {
    if (_formKey.currentState!.validate()) {
      if (_selectedAuthorId == null || _selectedVendorId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select both an Author and a Vendor', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
        return;
      }

      final selectedAuthor = authors.firstWhere((a) => a.id == _selectedAuthorId, orElse: () => authors.first);

      final newBook = BookModel(
        id: widget.book?.id ?? '',
        title: _titleController.text,
        author: selectedAuthor.name, // Ensure backward compatibility with UI expecting Author name
        authorId: _selectedAuthorId,
        vendorId: _selectedVendorId,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        rating: double.tryParse(_ratingController.text) ?? 5.0,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : 'https://via.placeholder.com/150',
        category: _categoryController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Builder(
        builder: (context) {
          final authorState = context.watch<AuthorsCubit>().state;
          final vendorState = context.watch<VendorsCubit>().state;

          bool isLoading = authorState is AuthorsLoading || vendorState is VendorsLoading;
          bool hasError = authorState is AuthorsError || vendorState is VendorsError;

          if (isLoading) return const Center(child: CircularProgressIndicator());
          if (hasError) return const Center(child: Text('Failed to load required data.'));

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
                      authors.isEmpty ? 'No Authors found!' : 'No Vendors found!',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You must add authors and vendors before you can create a book.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                      onPressed: () => context.pop(),
                      child: const Text('Go Back', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            );
          }

          if (_selectedAuthorId != null && !authors.any((a) => a.id == _selectedAuthorId)) {
            _selectedAuthorId = null;
          }
          if (_selectedVendorId != null && !vendors.any((v) => v.id == _selectedVendorId)) {
            _selectedVendorId = null;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Author', border: OutlineInputBorder()),
                    value: _selectedAuthorId,
                    items: authors.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))).toList(),
                    onChanged: (val) => setState(() => _selectedAuthorId = val),
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Vendor', border: OutlineInputBorder()),
                    value: _selectedVendorId,
                    items: vendors.map((v) => DropdownMenuItem(value: v.id, child: Text(v.name))).toList(),
                    onChanged: (val) => setState(() => _selectedVendorId = val),
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (v) => v == null || v.isEmpty ? 'Required' : (double.tryParse(v) == null ? 'Invalid Number' : null),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _stockController,
                          decoration: const InputDecoration(labelText: 'Stock', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (v) => v == null || v.isEmpty ? 'Required' : (int.tryParse(v) == null ? 'Invalid Int' : null),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _submit(authors),
                      child: Text(widget.book == null ? 'Add Book' : 'Save Changes', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
