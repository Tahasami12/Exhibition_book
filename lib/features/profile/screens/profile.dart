import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/profile/screens/favorites.dart';
import 'package:exhibition_book/features/profile/screens/help_center.dart';
import 'package:exhibition_book/features/profile/screens/my_account.dart';
import 'package:exhibition_book/features/profile/screens/offers.dart';
import 'package:exhibition_book/features/profile/screens/order_history.dart';
import 'package:exhibition_book/features/chat/presentation/views/user_chat_view.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exhibition_book/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exhibition_book/core/widgets/language_toggle_button.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

/// Profile tab content.
/// Returns only body content — MainShell provides the Scaffold + BottomNav.
/// Removed GetMaterialApp wrapper (was creating a separate app tree
/// that broke Provider and caused double bottom nav).
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── App Bar area ──
          AppBar(
            title: Text(
              t.profile,
              style: TextStyle(
                color: cs.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            backgroundColor: theme.scaffoldBackgroundColor,
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
                      FirebaseAuth.instance.currentUser?.displayName ??
                          "User Name",
                      style: TextStyle(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ??
                          "email@example.com",
                      style: TextStyle(
                        color: cs.onSurface.withValues(alpha: 0.6),
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
                    _showLogoutSheet(context, t);
                  },
                  child: SizedBox(
                    width: 60,
                    height: 50,
                    child: Center(
                      child: Text(
                        t.logout,
                        style: const TextStyle(
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
              context: context,
              label: t.myAccount,
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
              context: context,
              label: t.offersPromos,
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
              context: context,
              label: t.yourFavorites,
              avatarName: "favorite.svg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Favorites()),
              );
            },
          ),
          InkWell(
            child: makeNavigationRecord(
              context: context,
              label: t.orderHistory,
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
              context: context,
              label: t.helpCenter,
              avatarName: "help.svg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HelpCenter()),
              );
            },
          ),
          InkWell(
            child: makeNavigationRecord(
              context: context,
              label: t.supportChat,
              avatarName: "help.svg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserChatView()),
              );
            },
          ),

          // ── Language Toggle ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color ?? cs.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.language, color: cs.primary),
                ),
                const SizedBox(width: 10),
                Text(
                  t.language,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: cs.onSurface,
                  ),
                ),
                const Spacer(),
                const LanguageToggleButton(),
              ],
            ),
          ),

          // ── Dark Mode Toggle ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  t.darkMode,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                _DarkModeSwitch(),
              ],
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 16)),
        ],
      ),
    );
  }

  /// Shows the logout confirmation bottom sheet using standard Flutter API.
  void _showLogoutSheet(BuildContext context, AppStrings t) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder:
          (_) => Container(
            height: 312,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.logout,
                    style: const TextStyle(
                      color: AppColors.grey900,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    t.logoutConfirm,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey900,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Logout button
                  GestureDetector(
                    child: makeBottomSheetButton(
                      label: t.logout,
                      labelColor: AppColors.background,
                      buttonColor: AppColors.primary,
                    ),
                    onTap: () async {
                      await context.read<AuthCubit>().signOut();
                      if (context.mounted) {
                        Navigator.pop(context); // Close the bottom sheet
                        context.go('/login'); // Navigate to login
                      }
                    },
                  ),
                  const SizedBox(height: 15),

                  // Cancel button
                  GestureDetector(
                    child: makeBottomSheetButton(
                      label: t.cancel,
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

/// A stateful Switch widget that reads the current AdaptiveTheme mode
/// and lets the user toggle between light and dark.
class _DarkModeSwitch extends StatefulWidget {
  @override
  State<_DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<_DarkModeSwitch> {
  bool _isDark = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mode = AdaptiveTheme.of(context).mode;
    _isDark =
        mode == AdaptiveThemeMode.dark ||
        (mode == AdaptiveThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDark,
      onChanged: (val) {
        setState(() => _isDark = val);
        if (val) {
          AdaptiveTheme.of(context).setDark();
        } else {
          AdaptiveTheme.of(context).setLight();
        }
      },
    );
  }
}
