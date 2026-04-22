import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final String title;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final Widget? prefixIcon;
  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  const CustomTextfield({

    super.key,
    this .title="",
    this.isPassword = false,
    this.validator,
    this.autoFocus = false,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.controller
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    print("Build form Custom TextField");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFormField(
          controller: widget.controller,
          autofocus: widget.autoFocus,
          obscureText: widget.isPassword && isObscure,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,



            hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: Responsive.responsiveFontSize(context, 16),
              height: 1.5,
              color: Color(0xFFE0E0E0),
            ),




            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 18,
            ),

            suffixIcon: widget.isPassword
                ? InkWell(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: Icon(
                isObscure
                    ? Icons.visibility_off
                    : Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: Color(0xffFAFAFA), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),

          ),

        ),
      ],
    );
  }
}
