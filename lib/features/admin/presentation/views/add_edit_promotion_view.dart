import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_promotions_cubit.dart';
import 'package:exhibition_book/features/home/data/models/promotion_model.dart';
// import 'package:exhibition_book/features/home/presentation/cubit/promotions_cubit.dart'; // Typically refresh this if active.

class AddEditPromotionView extends StatefulWidget {
  final PromotionModel? promotion;
  const AddEditPromotionView({super.key, this.promotion});

  @override
  State<AddEditPromotionView> createState() => _AddEditPromotionViewState();
}

class _AddEditPromotionViewState extends State<AddEditPromotionView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _titleController;
  late TextEditingController _discountController;
  late TextEditingController _imageUrlController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.promotion?.title ?? '');
    _discountController = TextEditingController(text: widget.promotion?.discount ?? '');
    _imageUrlController = TextEditingController(text: widget.promotion?.imageUrl ?? '');
    _isActive = widget.promotion?.isActive ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _discountController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPromo = PromotionModel(
        id: widget.promotion?.id ?? '',
        title: _titleController.text,
        discount: _discountController.text,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : 'https://via.placeholder.com/150',
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promotion == null ? 'Add Promotion' : 'Edit Promotion', style: const TextStyle(color: Colors.white)),
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
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Discount Text', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Banner Image URL', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Active Promotion?'),
                subtitle: const Text('Toggle visibility on the home screen.'),
                value: _isActive,
                onChanged: (val) {
                  setState(() {
                    _isActive = val;
                  });
                },
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
                  child: Text(widget.promotion == null ? 'Add Promotion' : 'Save Changes', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
