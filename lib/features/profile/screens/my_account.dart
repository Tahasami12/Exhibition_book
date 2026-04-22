import 'dart:io';
import 'package:exhibition_book/core/enums/field_type.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      nameController.text = user.displayName ?? '';
      emailController.text = user.email ?? '';
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: makeAppBar(
        title: t.myAccountTitle,
        titleColor: AppColors.textPrimary,
        enableLeading: true,
        barBackgroundColor: AppColors.background,
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.grey200,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : (user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : const AssetImage("assets/images/test-img.jpg")) as ImageProvider,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: _pickImage,
                  child: Text(
                    t.changePicture,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _makeTextFiled(
                  controller: nameController,
                  filedLabel: t.name,
                  type: FieldType.name,
                  t: t,
                ),
                _makeTextFiled(
                  controller: emailController,
                  filedLabel: t.email,
                  type: FieldType.email,
                  t: t,
                  enabled: false, // Email usually handled separately
                ),
                _makeTextFiled(
                  controller: phoneController,
                  filedLabel: t.phoneLabel,
                  type: FieldType.phone,
                  t: t,
                ),
                _makeTextFiled(
                  controller: passwdController,
                  filedLabel: t.password,
                  type: FieldType.password,
                  t: t,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _isLoading ? null : () => _saveChanges(t),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              t.saveChanges,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveChanges(AppStrings t) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      // 1. Update Profile Picture
      String? photoUrl = user.photoURL;
      if (_pickedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_profiles')
            .child('${user.uid}.jpg');
        
        await storageRef.putFile(_pickedImage!);
        photoUrl = await storageRef.getDownloadURL();
        await user.updatePhotoURL(photoUrl);
      }

      // 2. Update Display Name and other info
      final newName = nameController.text.trim();
      if (newName.isNotEmpty && (newName != user.displayName || _pickedImage != null)) {
        await user.updateDisplayName(newName);
        
        Map<String, dynamic> updateData = {'name': newName};
        if (photoUrl != null) updateData['photoUrl'] = photoUrl;
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(updateData);
      }

      // 3. Update Password
      final newPass = passwdController.text.trim();
      if (newPass.isNotEmpty) {
        if (newPass.length < 6) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(t.passErrorLength)),
            );
          }
          setState(() => _isLoading = false);
          return;
        }
        await user.updatePassword(newPass);
        passwdController.clear();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.profileUpdated),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${t.profileUpdateError}: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Widget _makeTextFiled({
    required TextEditingController controller,
    required String filedLabel,
    required FieldType type,
    required AppStrings t,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filedLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.grey900,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            enabled: enabled,
            obscureText: type == FieldType.password && _isObscure,
            keyboardType: type == FieldType.phone
                ? const TextInputType.numberWithOptions()
                : null,
            autovalidateMode: AutovalidateMode.onUnfocus,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: enabled ? AppColors.grey900 : AppColors.grey500,
            ),
            decoration: InputDecoration(
              fillColor: AppColors.grey200,
              filled: true,
              hintText: filedLabel,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: AppColors.grey500, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: AppColors.grey500, width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: AppColors.grey200, width: 1.0),
              ),
              prefixIcon: type == FieldType.phone
                  ? Image.asset(
                      scale: 3.5,
                      "assets/images/phoneoftextfield.png",
                    )
                  : null,
              suffixIcon: type == FieldType.password
                  ? IconButton(
                      iconSize: 20,
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.grey500,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
