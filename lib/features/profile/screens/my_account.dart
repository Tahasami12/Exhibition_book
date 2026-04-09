import 'package:exhibition_book/core/enums/field_type.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';

/// TODO: you need to make it stateless.
class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccount> {
  // get access to the text fields' data.
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // password-related variables.
  bool _isObscure = false;
  TextEditingController passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: makeAppBar(
          title: "My Account",
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
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/test-img.jpg"),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      ///What should this do?
                    },
                    child: Text(
                      "Change Picture",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  _makeTextFiled(
                    controller: nameController,
                    filedLabel: "Name",
                    type: FieldType.name,
                  ),
                  _makeTextFiled(
                    controller: emailController,
                    filedLabel: "Email",
                    type: FieldType.email,
                  ),
                  _makeTextFiled(
                    controller: phoneController,
                    filedLabel: "Phone Number",
                    type: FieldType.phone,
                  ),
                  _makeTextFiled(
                    controller: passwdController,
                    filedLabel: "Password",
                    type: FieldType.password,
                  ),

                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // a private method to build each text field.
  Widget _makeTextFiled({
    required TextEditingController controller,
    required String filedLabel,
    required FieldType type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filedLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.grey900,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            obscureText: type == FieldType.password && _isObscure,
            keyboardType:
                type == FieldType.phone
                    ? TextInputType.numberWithOptions()
                    : null,
            autovalidateMode: AutovalidateMode.onUnfocus,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.grey900,
            ),
            validator: (value) {
              // return value == "" ? "Invalid name." : null;
            },
            decoration: InputDecoration(
              fillColor: AppColors.grey200,
              filled: true,
              hintText: filedLabel,

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.grey500, width: 1.0),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.grey500, width: 1.0),
              ),

              prefixIcon:
                  type == FieldType.phone
                      ? Image.asset(
                        scale: 3.5,
                        "assets/images/phoneoftextfield.png",
                      )
                      : null,
              suffixIcon:
                  type == FieldType.password
                      ? IconButton(
                        iconSize: 20,
                        icon:
                            _isObscure
                                ? const Icon(
                                  Icons.visibility_off,
                                  color: AppColors.grey500,
                                )
                                : const Icon(
                                  Icons.visibility,
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
            controller: controller,
          ),
        ],
      ),
    );
  }
}
