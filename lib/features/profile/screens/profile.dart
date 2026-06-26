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
    final cs = theme.colorScheme;    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context) ?? double.infinity,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
              child: isMobile
                  ? _buildMobileLayout(context, t, theme, cs)
                  : _buildTabletLayout(context, t, theme, cs),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppStrings t,
    ThemeData theme,
    ColorScheme cs,
  ) {
    return Column(
      children: [
        _buildProfileHeader(context, t, theme, cs),
        const Divider(height: 32),
        _buildNavigationMenu(context, t),
        const Divider(height: 32),
        _buildLanguageToggle(context, t, theme, cs),
        SizedBox(height: Responsive.responsiveSpacing(context, 16)),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    AppStrings t,
    ThemeData theme,
    ColorScheme cs,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Profile Info
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildProfileHeader(context, t, theme, cs),
              const SizedBox(height: 24),
              _buildLanguageToggle(context, t, theme, cs),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Right Column: Menu Items
        Expanded(
          flex: 3,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                _buildNavigationMenu(context, t),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    AppStrings t,
    ThemeData theme,
    ColorScheme cs,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.responsiveSpacing(context, 35),
            backgroundColor: AppColors.grey200,
            backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                : const AssetImage("assets/images/test-img.jpg")
                    as ImageProvider,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ??
                      t.userNamePlaceholder,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveFontSize(context, 16),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? t.emailPlaceholder,
                  style: TextStyle(
                    color: cs.onSurface.withValues(alpha: 0.6),
                    fontSize: Responsive.responsiveFontSize(context, 14),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showLogoutSheet(context, t),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                t.logout,
                style: const TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu(BuildContext context, AppStrings t) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          t.myAccount,
          "profile.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MyAccount()),
          ),
        ),
        _buildMenuItem(
          context,
          t.offersPromos,
          "offer.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Offers()),
          ),
        ),
        _buildMenuItem(
          context,
          t.yourFavorites,
          "favorite.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Favorites()),
          ),
        ),
        _buildMenuItem(
          context,
          t.orderHistory,
          "history.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => OrderHistory()),
          ),
        ),
        _buildMenuItem(
          context,
          t.helpCenter,
          "help.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HelpCenter()),
          ),
        ),
        _buildMenuItem(
          context,
          t.supportChat,
          "help.svg",
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserChatView()),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String label,
    String icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: makeNavigationRecord(
        context: context,
        label: label,
        avatarName: icon,
      ),
    );
  }

  Widget _buildLanguageToggle(
    BuildContext context,
    AppStrings t,
    ThemeData theme,
    ColorScheme cs,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
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
