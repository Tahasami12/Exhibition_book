import 'package:exhibition_book/features/profile/screens/favorites.dart';
import 'package:exhibition_book/features/profile/screens/help_center.dart';
import 'package:exhibition_book/features/profile/screens/my_account.dart';
import 'package:exhibition_book/features/profile/screens/offers.dart';
import 'package:exhibition_book/features/profile/screens/order_history.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';

/// Profile tab content.
/// Returns only body content — MainShell provides the Scaffold + BottomNav.
/// Removed GetMaterialApp wrapper (was creating a separate app tree
/// that broke Provider and caused double bottom nav).
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── App Bar area ──
        AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        const Divider(height: 1),

        // ── User info row ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/test-img.jpg"),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                      color: AppColors.grey900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "(+1) 234 567 890",
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Logout button
              GestureDetector(
                onTap: () {
                  _showLogoutSheet(context);
                },
                child: SizedBox(
                  width: 60,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // ── Navigation menu items ──
        InkWell(
          child: makeNavigationRecord(
            label: "My Account",
            avatarName: "profile.svg",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MyAccount()),
            );
          },
        ),
        InkWell(
          child: makeNavigationRecord(
            label: "Address",
            avatarName: "address.svg",
          ),
          onTap: () {
            // TODO: Navigate to Address screen
          },
        ),
        InkWell(
          child: makeNavigationRecord(
            label: "Offers & Promos",
            avatarName: "offer.svg",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Offers()),
            );
          },
        ),
        InkWell(
          child: makeNavigationRecord(
            label: "Your Favorites",
            avatarName: "favorite.svg",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Favorites()),
            );
          },
        ),
        InkWell(
          child: makeNavigationRecord(
            label: "Order History",
            avatarName: "history.svg",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrderHistory()),
            );
          },
        ),
        InkWell(
          child: makeNavigationRecord(
            label: "Help Center",
            avatarName: "help.svg",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HelpCenter()),
            );
          },
        ),
      ],
    );
  }

  /// Shows the logout confirmation bottom sheet using standard Flutter API.
  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) => Container(
        height: 312,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Logout",
                style: TextStyle(
                  color: AppColors.grey900,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Are you sure you want to logout?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey900,
                ),
              ),
              const SizedBox(height: 15),

              // Logout button
              GestureDetector(
                child: makeBottomSheetButton(
                  label: "Logout",
                  labelColor: AppColors.background,
                  buttonColor: AppColors.primary,
                ),
                onTap: () {
                  ///TODO: Implement logout logic
                },
              ),
              const SizedBox(height: 15),

              // Cancel button
              GestureDetector(
                child: makeBottomSheetButton(
                  label: "Cancel",
                  buttonColor: AppColors.grey300,
                  labelColor: AppColors.primary,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
