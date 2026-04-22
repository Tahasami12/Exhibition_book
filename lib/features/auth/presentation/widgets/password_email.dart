import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_text_field.dart';
import 'email_validation.dart';

class TextForm2 extends StatelessWidget {
  const TextForm2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_labe2(context, "Password"), _input2(context)],
    );
  }

  Widget _labe2(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 20),
        fontWeight: FontWeight.w500,
        color: kGrey900,
        height: 1.4,
      ),
    ),
  );

  Widget _input2(BuildContext context) {
    return CustomTextfield(
      hintText: "Your password",
      isPassword: true,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Password is required";
        }
        if (value.length < 8) {
          return "Password should be more than 8 letters";
        }
        return null; // fix missing return value warning
      },
    );
  }
}

class TextForm extends StatelessWidget {
  const TextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, "Email"), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 16),
        fontWeight: FontWeight.w500,
        color: kGrey900,
        height: Responsive.responsiveSpacing(context, 1.4),
      ),
    ),
  );
  Widget _input1(BuildContext context) {

    return CustomTextfield(
      hintText: "Your email",
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Email is required";
        }
        if (!value.trim().emailValid()) {
          return "Email isn't valid";
        }
        return null;
      },
    );
  }
}

class TextForm1 extends StatelessWidget {
  const TextForm1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, "Name"), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 16),
        fontWeight: FontWeight.w500,
        color: kGrey900,
        height: 1.4,
      ),
    ),
  );
  Widget _input1(BuildContext context) {
    return CustomTextfield(
      hintText: "Your name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name is required";
        }
        return null;
      },
    );
  }
}