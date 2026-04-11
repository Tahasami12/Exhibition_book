import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: makeAppBar(
        title: "Order History",
        titleColor: AppColors.background,
        enableLeading: true,
        barBackgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),

                /// 🔹 Title
                Text(
                  "Help Center",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.07,
                    color: AppColors.background,
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                /// 🔹 Subtitle
                Text(
                  "Tell us how we can help 👋",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: AppColors.grey500,
                  ),
                ),

                SizedBox(height: size.height * 0.005),

                /// 🔹 Description
                Text(
                  "Chapters are standing by for services & support!",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: AppColors.grey500,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                /// 🔹 Cards
                Row(
                  children: [
                    Expanded(
                      child: makeHelpMethod(
                        icon: AssetImage("assets/images/message.png"),
                        label: "Email",
                        description: "Send to your email",
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: makeHelpMethod(
                        icon: AssetImage("assets/images/phone.png"),
                        label: "Phone Number",
                        description: "Send to your phone",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
