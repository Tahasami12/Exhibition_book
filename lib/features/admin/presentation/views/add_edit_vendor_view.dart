import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_vendors_cubit.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'package:exhibition_book/features/home/presentation/cubit/vendors_cubit.dart';

class AddEditVendorView extends StatefulWidget {
  final VendorModel? vendor;
  const AddEditVendorView({super.key, this.vendor});

  @override
  State<AddEditVendorView> createState() => _AddEditVendorViewState();
}

class _AddEditVendorViewState extends State<AddEditVendorView> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _logoUrlController;
  late TextEditingController _ratingController;
  bool _isBestVendor = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vendor?.name ?? '');
    _logoUrlController = TextEditingController(text: widget.vendor?.logoUrl ?? '');
    _ratingController = TextEditingController(text: widget.vendor?.rating.toString() ?? '5.0');
    _isBestVendor = widget.vendor?.isBestVendor ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _logoUrlController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newVendor = VendorModel(
        id: widget.vendor?.id ?? '',
        name: _nameController.text,
        logoUrl: _logoUrlController.text.isNotEmpty ? _logoUrlController.text : 'https://via.placeholder.com/150',
        rating: double.tryParse(_ratingController.text) ?? 5.0,
        isBestVendor: _isBestVendor,
      );

      if (widget.vendor == null) {
        context.read<AdminVendorsCubit>().addVendor(newVendor);
      } else {
        context.read<AdminVendorsCubit>().updateVendor(newVendor);
      }
      
      // refresh user-facing vendors automatically
      context.read<VendorsCubit>().fetchVendors();

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vendor == null ? 'Add Vendor' : 'Edit Vendor', style: const TextStyle(color: Colors.white)),
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
                decoration: const InputDecoration(labelText: 'Store Name', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _logoUrlController,
                decoration: const InputDecoration(labelText: 'Logo URL', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating (0.0 - 5.0)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : (double.tryParse(v) == null ? 'Invalid Int' : null),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Best Vendor?'),
                subtitle: const Text('Flags this vendor as premium.'),
                value: _isBestVendor,
                onChanged: (val) {
                  setState(() {
                    _isBestVendor = val;
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
                  child: Text(widget.vendor == null ? 'Add Vendor' : 'Save Changes', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
