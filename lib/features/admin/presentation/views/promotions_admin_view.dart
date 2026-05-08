import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_promotions_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_promotions_state.dart';

class PromotionsAdminView extends StatefulWidget {
  const PromotionsAdminView({super.key});

  @override
  State<PromotionsAdminView> createState() => _PromotionsAdminViewState();
}

class _PromotionsAdminViewState extends State<PromotionsAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminPromotionsCubit>().fetchPromotions();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isArabic = AppStrings.isArabic(context);

    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: t.managePromotions,
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/add_edit_promotion'),
          ),
        ],
      ),
      body: BlocConsumer<AdminPromotionsCubit, AdminPromotionsState>(
        listener: (context, state) {
          if (state is AdminPromotionsActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AdminTheme.success,
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state is AdminPromotionsActionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: AdminTheme.danger,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        buildWhen: (_, current) =>
            current is AdminPromotionsLoading ||
            current is AdminPromotionsLoaded ||
            current is AdminPromotionsError,
        builder: (context, state) {
          if (state is AdminPromotionsLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: AdminTheme.primary));
          }
          if (state is AdminPromotionsError) {
            return AdminTheme.errorState(state.message,
                () => context.read<AdminPromotionsCubit>().fetchPromotions());
          }
          if (state is AdminPromotionsLoaded) {
            if (state.promotions.isEmpty) {
              return AdminTheme.emptyState(t.noPromotionsFound,
                  icon: Icons.campaign_outlined);
            }
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.promotions.length,
                  itemBuilder: (context, index) {
                    final promo = state.promotions[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AdminTheme.radiusCard),
                        boxShadow: AdminTheme.cardShadow,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: promo.imageUrl.isNotEmpty
                              ? Image.network(promo.imageUrl,
                                  width: 70,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                      Icons.campaign,
                                      size: 40,
                                      color: AdminTheme.primary))
                              : const Icon(Icons.campaign,
                                  size: 40, color: AdminTheme.primary),
                        ),
                        title: Row(
                          children: [
                            Flexible(
                              child: Text(promo.title(isArabic),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AdminTheme.textPrimary),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            if (!promo.isActive)
                               Padding(
                                padding: EdgeInsets.only(
                                  left: isArabic ? 0 : 6,
                                  right: isArabic ? 6 : 0,
                                ),
                                child: const Icon(Icons.visibility_off,
                                    color: AdminTheme.textSub, size: 16),
                              ),
                          ],
                        ),
                        subtitle: Text(promo.discount(isArabic),
                            style: const TextStyle(color: AdminTheme.textSub)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  color: AdminTheme.primary),
                              onPressed: () =>
                                  context.push('/add_edit_promotion', extra: promo),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: AdminTheme.danger),
                              onPressed: () async {
                                final confirmed = await AdminTheme.confirmDelete(
                                    context, promo.title(isArabic));
                                if (confirmed && context.mounted) {
                                  context
                                      .read<AdminPromotionsCubit>()
                                      .deletePromotion(promo.id);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
