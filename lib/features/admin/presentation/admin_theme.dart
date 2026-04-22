import 'package:flutter/material.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';

/// Shared UI helpers for the Admin panel.
/// All hardcoded colors removed — everything derives from [AppColors].
abstract class AdminTheme {
  // ─── Core palette (mirrors user app) ────────────────────────────────────────
  static const Color primary = AppColors.primary;          // #4A4E9B
  static const Color primaryLight = Color(0xFFEEEFF8);    // subtle tint of primary
  static const Color danger = AppColors.red;
  static const Color success = AppColors.green;
  static const Color warning = AppColors.orange;
  static const Color bg = AppColors.background;
  static const Color textPrimary = AppColors.textPrimary;
  static const Color textSub = AppColors.textSecondary;
  static const Color divider = AppColors.grey200;

  // ─── Border radius ───────────────────────────────────────────────────────────
  static const double radiusCard = 16;
  static const double radiusSmall = 10;

  // ─── Shadows ─────────────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  // ─── AppBar decoration ───────────────────────────────────────────────────────
  static AppBar adminAppBar({
    required String title,
    required BuildContext context,
    List<Widget>? actions,
    bool showBack = true,
  }) {
    return AppBar(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: showBack,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: actions,
    );
  }

  // ─── Primary button ──────────────────────────────────────────────────────────
  static Widget primaryButton({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
      ),
    );
  }

  // ─── Danger (delete) button ──────────────────────────────────────────────────
  static Widget dangerButton({
    required String label,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: danger,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
        ),
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    );
  }

  // ─── Card wrapper ────────────────────────────────────────────────────────────
  static Widget card({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusCard),
        boxShadow: cardShadow,
      ),
      child: child,
    );
  }

  // ─── Section header ──────────────────────────────────────────────────────────
  static Widget sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
        ),
      );

  // ─── Status chip ─────────────────────────────────────────────────────────────
  static Color statusColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppColors.blue;
      case 'shipped':
        return AppColors.orange;
      case 'delivered':
        return AppColors.green;
      case 'cancelled':
        return AppColors.red;
      default:
        return AppColors.grey500; // pending / unknown
    }
  }

  static Widget statusChip(String status, {double fontSize = 11}) {
    final color = statusColor(status);
    final labels = {
      'pending': 'Pending',
      'confirmed': 'Confirmed',
      'shipped': 'Shipped',
      'delivered': 'Delivered',
      'cancelled': 'Cancelled',
    };
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        labels[status] ?? status.toUpperCase(),
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  // ─── Delete confirmation dialog ───────────────────────────────────────────────
  static Future<bool> confirmDelete(
      BuildContext context, String itemName) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusCard)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: danger),
            const SizedBox(width: 8),
            const Text('Confirm Delete'),
          ],
        ),
        content: Text('Are you sure you want to delete "$itemName"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: textSub)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: danger, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // ─── Common text field ────────────────────────────────────────────────────────
  static InputDecoration fieldDecoration(String label,
      {String? hint, IconData? prefixIcon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: primary) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  // ─── Empty state ─────────────────────────────────────────────────────────────
  static Widget emptyState(String message, {IconData icon = Icons.inbox}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.grey300),
          const SizedBox(height: 16),
          Text(message,
              style: const TextStyle(
                  color: AppColors.grey500, fontSize: 15)),
        ],
      ),
    );
  }

  // ─── Error state ──────────────────────────────────────────────────────────────
  static Widget errorState(String message, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.red),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(radiusSmall)),
            ),
          ),
        ],
      ),
    );
  }
}
