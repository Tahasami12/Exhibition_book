import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exhibition_book/features/chat/presentation/views/admin_chats_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AdminTheme.adminAppBar(
        title: 'لوحة تحكم الأدمن',
        context: context,
        showBack: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
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
                children: const [
                  Text('Welcome, Admin 👋',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Manage the app easily from here',
                      style:
                          TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            AdminTheme.sectionTitle('Main Sections'),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: [
                _ModuleCard(
                    title: 'Books',
                    subtitle: 'Manage Books',
                    icon: Icons.book_outlined,
                    route: '/admin_books'),
                _ModuleCard(
                    title: 'Authors',
                    subtitle: 'Manage Authors',
                    icon: Icons.person_outline,
                    route: '/admin_authors'),
                _ModuleCard(
                    title: 'Vendors',
                    subtitle: 'Manage Vendors',
                    icon: Icons.store_outlined,
                    route: '/admin_vendors'),
                _ModuleCard(
                    title: 'Users',
                    subtitle: 'Manage Accounts',
                    icon: Icons.people_outline,
                    route: '/admin_users'),
                _ModuleCard(
                    title: 'Orders',
                    subtitle: 'Manage Orders',
                    icon: Icons.receipt_long_outlined,
                    route: '/admin_orders'),
                _ModuleCard(
                    title: 'Promotions',
                    subtitle: 'Manage Promos',
                    icon: Icons.campaign_outlined,
                    route: '/admin_promotions'),
                _ModuleCard(
                    title: 'Chats',
                    subtitle: 'Support Chats',
                    icon: Icons.chat_bubble_outline,
                    route: '/admin_chats'),
              ],
            ),
            const SizedBox(height: 28),

            AdminTheme.sectionTitle('Quick Actions'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickChip(
                    label: 'Add Book',
                    icon: Icons.add_box_outlined,
                    route: '/add_edit_book'),
                _QuickChip(
                    label: 'Add Author',
                    icon: Icons.person_add_outlined,
                    route: '/add_edit_author'),
                _QuickChip(
                    label: 'Add Vendor',
                    icon: Icons.add_business_outlined,
                    route: '/add_edit_vendor'),
                _QuickChip(
                    label: 'Add Promo',
                    icon: Icons.add_alert_outlined,
                    route: '/add_edit_promotion'),
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
          borderRadius:
              BorderRadius.circular(AdminTheme.radiusCard),
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
              child: Icon(icon,
                  size: 28, color: AdminTheme.primary),
            ),
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AdminTheme.textPrimary)),
            const SizedBox(height: 3),
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 12,
                    color: AdminTheme.textSub)),
          ],
        ),
      ),
    );
  }
}

// ─── Quick chip ───────────────────────────────────────────────────────────────

class _QuickChip extends StatelessWidget {
  const _QuickChip(
      {required this.label,
      required this.icon,
      required this.route});

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: AdminTheme.primary),
      label: Text(label,
          style: const TextStyle(
              color: AdminTheme.primary,
              fontWeight: FontWeight.w600)),
      backgroundColor: AdminTheme.primaryLight,
      side: const BorderSide(color: AdminTheme.primary, width: 0.5),
      onPressed: () => context.push(route),
    );
  }
}
