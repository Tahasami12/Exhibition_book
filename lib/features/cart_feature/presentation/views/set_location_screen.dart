
import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../data/delivery_address.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _confirmLocation() {
    if (_nameController.text.trim().isEmpty ||
        _governorateController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final address = DeliveryAddress(
      name: _nameController.text.trim(),
      governorate: _governorateController.text.trim(),
      city: _cityController.text.trim(),
    );

    Navigator.pop(context, address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Location',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
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
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                    _buildTextField(
                      context: context,
                      label: 'Name',
                      controller: _nameController,
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                    _buildTextField(
                      context: context,
                      label:'Governorate',
                      controller: _governorateController,
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                    _buildTextField(
                      context: context,
                      label: 'City',
                      controller: _cityController,
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 40)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _confirmLocation,
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
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirmation',
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.responsiveFontSize(context, 14),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 16),
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[500]!
                  : Colors.grey[600]!,
              fontSize: Responsive.responsiveFontSize(context, 14),
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]!
                : Colors.grey[50]!,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
