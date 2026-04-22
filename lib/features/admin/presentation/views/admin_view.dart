import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exhibition_book/core/widgets/language_toggle_button.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final user = FirebaseAuth.instance.currentUser;
    String adminName = user?.displayName?.trim() ?? '';
    if (adminName.isEmpty && user?.email != null) {
      adminName = user!.email!.split('@').first;
    }
    if (adminName.isEmpty) adminName = 'Admin';
    if (adminName.isNotEmpty) {
      adminName = '${adminName[0].toUpperCase()}${adminName.substring(1)}';
    }

    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AdminTheme.adminAppBar(
        title: t.adminDashboard,
        context: context,
        showBack: false,
        actions: [
          const LanguageToggleIconButton(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: t.signOut,
            onPressed: () async {
              await context.read<AuthCubit>().signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Welcome banner ─────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF6669BE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AdminTheme.radiusCard),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${t.adminWelcome}, $adminName 👋',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.adminSubtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            AdminTheme.sectionTitle(t.mainSections),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: [
                _ModuleCard(
                  title: t.books,
                  subtitle: t.manageBooks,
                  icon: Icons.book_outlined,
                  route: '/admin_books',
                ),
                _ModuleCard(
                  title: t.authorsLabel,
                  subtitle: t.manageAuth,
                  icon: Icons.person_outline,
                  route: '/admin_authors',
                ),
                _ModuleCard(
                  title: t.vendors,
                  subtitle: t.manageVend,
                  icon: Icons.store_outlined,
                  route: '/admin_vendors',
                ),
                _ModuleCard(
                  title: t.users,
                  subtitle: t.manageUsers,
                  icon: Icons.people_outline,
                  route: '/admin_users',
                ),
                _ModuleCard(
                  title: t.orders,
                  subtitle: t.manageOrders,
                  icon: Icons.receipt_long_outlined,
                  route: '/admin_orders',
                ),
                _ModuleCard(
                  title: t.promotions,
                  subtitle: t.managePromos,
                  icon: Icons.campaign_outlined,
                  route: '/admin_promotions',
                ),
                _ModuleCard(
                  title: t.chats,
                  subtitle: t.supportChats,
                  icon: Icons.chat_bubble_outline,
                  route: '/admin_chats',
                ),
              ],
            ),
            const SizedBox(height: 28),

            AdminTheme.sectionTitle(t.quickActions),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickChip(
                  label: t.addBook,
                  icon: Icons.add_box_outlined,
                  route: '/add_edit_book',
                ),
                _QuickChip(
                  label: t.addAuthor,
                  icon: Icons.person_add_outlined,
                  route: '/add_edit_author',
                ),
                _QuickChip(
                  label: t.addVendor,
                  icon: Icons.add_business_outlined,
                  route: '/add_edit_vendor',
                ),
                _QuickChip(
                  label: t.addPromo,
                  icon: Icons.add_alert_outlined,
                  route: '/add_edit_promotion',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Module card ──────────────────────────────────────────────────────────────

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(AdminTheme.radiusCard),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AdminTheme.radiusCard),
          boxShadow: AdminTheme.cardShadow,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AdminTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: AdminTheme.primary),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AdminTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: AdminTheme.textSub),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Quick chip ───────────────────────────────────────────────────────────────

class _QuickChip extends StatelessWidget {
  const _QuickChip({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: AdminTheme.primary),
      label: Text(
        label,
        style: const TextStyle(
          color: AdminTheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AdminTheme.primaryLight,
      side: const BorderSide(color: AdminTheme.primary, width: 0.5),
      onPressed: () => context.push(route),
    );
  }
}
