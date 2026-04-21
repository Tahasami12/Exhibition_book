import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_users_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_users_state.dart';

class UsersAdminView extends StatefulWidget {
  const UsersAdminView({super.key});

  @override
  State<UsersAdminView> createState() => _UsersAdminViewState();
}

class _UsersAdminViewState extends State<UsersAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminUsersCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: 'Manage Users',
        context: context,
      ),
      body: BlocConsumer<AdminUsersCubit, AdminUsersState>(
        listener: (context, state) {
          if (state is AdminUsersActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AdminTheme.success,
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state is AdminUsersActionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: AdminTheme.danger,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        buildWhen: (_, current) =>
            current is AdminUsersLoading ||
            current is AdminUsersLoaded ||
            current is AdminUsersError,
        builder: (context, state) {
          if (state is AdminUsersLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: AdminTheme.primary));
          }
          if (state is AdminUsersError) {
            return AdminTheme.errorState(state.message,
                () => context.read<AdminUsersCubit>().fetchUsers());
          }
          if (state is AdminUsersLoaded) {
            if (state.users.isEmpty) {
              return AdminTheme.emptyState('No users found.',
                  icon: Icons.people_outline);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                final isAdmin = user.role == 'admin';
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
                    leading: CircleAvatar(
                      backgroundColor: isAdmin
                          ? AdminTheme.primaryLight
                          : AdminTheme.divider,
                      child: Icon(
                        Icons.person,
                        color: isAdmin
                            ? AdminTheme.primary
                            : AdminTheme.textSub,
                      ),
                    ),
                    title: Row(
                      children: [
                        Flexible(
                          child: Text(user.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AdminTheme.textPrimary),
                              overflow: TextOverflow.ellipsis),
                        ),
                        if (isAdmin)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AdminTheme.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('ADMIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                    subtitle:
                        Text(user.email, style: const TextStyle(fontSize: 13)),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'make_admin') {
                          context
                              .read<AdminUsersCubit>()
                              .changeRole(user.id, 'admin');
                        } else if (value == 'remove_admin') {
                          context
                              .read<AdminUsersCubit>()
                              .changeRole(user.id, 'user');
                        } else if (value == 'delete') {
                          final confirmed = await AdminTheme.confirmDelete(
                              context, user.name);
                          if (confirmed && context.mounted) {
                            context.read<AdminUsersCubit>().deleteUser(user.id);
                          }
                        }
                      },
                      itemBuilder: (_) => [
                        if (!isAdmin)
                          const PopupMenuItem(
                              value: 'make_admin',
                              child: Text('Make Admin')),
                        if (isAdmin)
                          const PopupMenuItem(
                              value: 'remove_admin',
                              child: Text('Revoke Admin')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete User',
                              style: TextStyle(color: AdminTheme.danger)),
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
