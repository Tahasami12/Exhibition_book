import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: makeAppBar(
          title: "Order History",
          titleColor: AppColors.background,
          enableLeading: true,
          barBackgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.primary,
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Help Center",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: AppColors.background,
                      ),
                    ),
                    Text(
                      "Tell us how we can help 👋",
                      style: TextStyle(fontSize: 20, color: AppColors.grey500),
                    ),
                    Text(
                      "Chapters are standing by for services & support!",
                      style: TextStyle(fontSize: 20, color: AppColors.grey500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  makeHelpMethod(
                    icon: AssetImage("assets/images/message.png"),
                    label: "Email",
                    description: "Send to your email",
                  ),
                  SizedBox(width: 16),
                  makeHelpMethod(
                    icon: AssetImage("assets/images/phone.png"),
                    label: "Phone Number",
                    description: "Send to your phone",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}