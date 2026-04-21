import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_vendors_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_vendors_state.dart';

class VendorsAdminView extends StatefulWidget {
  const VendorsAdminView({super.key});

  @override
  State<VendorsAdminView> createState() => _VendorsAdminViewState();
}

class _VendorsAdminViewState extends State<VendorsAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminVendorsCubit>().fetchVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: 'Manage Vendors',
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/add_edit_vendor'),
          ),
        ],
      ),
      body: BlocConsumer<AdminVendorsCubit, AdminVendorsState>(
        listener: (context, state) {
          if (state is AdminVendorsActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AdminTheme.success,
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state is AdminVendorsActionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: AdminTheme.danger,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        buildWhen: (_, current) =>
            current is AdminVendorsLoading ||
            current is AdminVendorsLoaded ||
            current is AdminVendorsError,
        builder: (context, state) {
          if (state is AdminVendorsLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: AdminTheme.primary));
          }
          if (state is AdminVendorsError) {
            return AdminTheme.errorState(state.message,
                () => context.read<AdminVendorsCubit>().fetchVendors());
          }
          if (state is AdminVendorsLoaded) {
            if (state.vendors.isEmpty) {
              return AdminTheme.emptyState('No vendors found.',
                  icon: Icons.store_outlined);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.vendors.length,
              itemBuilder: (context, index) {
                final vendor = state.vendors[index];
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
                      child: vendor.logoUrl.isNotEmpty
                          ? Image.network(vendor.logoUrl,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                  Icons.store,
                                  size: 52,
                                  color: AdminTheme.primary))
                          : const Icon(Icons.store,
                              size: 52, color: AdminTheme.primary),
                    ),
                    title: Row(
                      children: [
                        Text(vendor.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AdminTheme.textPrimary)),
                        if (vendor.isBestVendor)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.star,
                                color: AppColors.yellow, size: 16),
                          ),
                      ],
                    ),
                    subtitle: Text('Rating: ${vendor.rating}',
                        style: const TextStyle(
                            color: AdminTheme.textSub, fontSize: 13)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              color: AdminTheme.primary),
                          onPressed: () =>
                              context.push('/add_edit_vendor', extra: vendor),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: AdminTheme.danger),
                          onPressed: () async {
                            final confirmed = await AdminTheme.confirmDelete(
                                context, vendor.name);
                            if (confirmed && context.mounted) {
                              context
                                  .read<AdminVendorsCubit>()
                                  .deleteVendor(vendor.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
