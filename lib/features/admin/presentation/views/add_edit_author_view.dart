import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_authors_cubit.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'package:exhibition_book/features/home/presentation/cubit/authors_cubit.dart';

class AddEditAuthorView extends StatefulWidget {
  final AuthorModel? author;
  const AddEditAuthorView({super.key, this.author});

  @override
  State<AddEditAuthorView> createState() => _AddEditAuthorViewState();
}

class _AddEditAuthorViewState extends State<AddEditAuthorView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _imageUrlController;
  late TextEditingController _booksCountController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.author?.name ?? '');
    _bioController = TextEditingController(text: widget.author?.bio ?? '');
    _imageUrlController = TextEditingController(text: widget.author?.imageUrl ?? '');
    _booksCountController = TextEditingController(text: widget.author?.booksCount.toString() ?? '0');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _imageUrlController.dispose();
    _booksCountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newAuthor = AuthorModel(
        id: widget.author?.id ?? '',
        name: _nameController.text,
        bio: _bioController.text,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : 'https://via.placeholder.com/150',
        booksCount: int.tryParse(_booksCountController.text) ?? 0,
      );

      if (widget.author == null) {
        context.read<AdminAuthorsCubit>().addAuthor(newAuthor);
      } else {
        context.read<AdminAuthorsCubit>().updateAuthor(newAuthor);
      }
      
      // Also refresh the user-facing authors automatically!
      context.read<AuthorsCubit>().fetchAuthors();

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.author == null ? 'Add Author' : 'Edit Author', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Bio', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _booksCountController,
                decoration: const InputDecoration(labelText: 'Books Count', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : (int.tryParse(v) == null ? 'Invalid Int' : null),
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
                  onPressed: _submit,
                  child: Text(widget.author == null ? 'Add Author' : 'Save Changes', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
