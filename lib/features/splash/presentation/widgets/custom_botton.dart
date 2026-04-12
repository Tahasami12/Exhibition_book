import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final Color color;
  final double height;
  final void Function()? onTap;
  final bool isLoading;
  const CustomBtn({
    super.key,
     this.title="",
    this.onTap,
    this.color = kPrimaryColor,
    this.height = 56,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : Text(
                  title,
                  style: TextStyle(
                    color: color == kPrimaryColor ? Colors.white : null,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}