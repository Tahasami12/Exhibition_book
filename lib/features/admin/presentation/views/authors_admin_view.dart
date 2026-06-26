import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_authors_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_authors_state.dart';

class AuthorsAdminView extends StatefulWidget {
  const AuthorsAdminView({super.key});

  @override
  State<AuthorsAdminView> createState() => _AuthorsAdminViewState();
}

class _AuthorsAdminViewState extends State<AuthorsAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminAuthorsCubit>().fetchAuthors();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isAr = AppStrings.isArabic(context);
    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: t.manageAuthors,
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/add_edit_author'),
          ),
        ],
      ),
      body: BlocConsumer<AdminAuthorsCubit, AdminAuthorsState>(
        listener: (context, state) {
          if (state is AdminAuthorsActionSuccess) {
            String msg = state.message;
            if (state.message.contains('deleted')) return; // Handled manually in onDelete with Undo
            if (state.message.contains('added')) msg = t.authorAdded;
            if (state.message.contains('updated')) msg = t.authorUpdated;
            
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(msg),
              backgroundColor: AdminTheme.success,
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state is AdminAuthorsActionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: AdminTheme.danger,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        buildWhen: (_, current) =>
            current is AdminAuthorsLoading ||
            current is AdminAuthorsLoaded ||
            current is AdminAuthorsError,
        builder: (context, state) {
          if (state is AdminAuthorsLoading) {
            return Center(
                child: CircularProgressIndicator(color: AdminTheme.primary));
          }
          if (state is AdminAuthorsError) {
            return AdminTheme.errorState(state.message,
                () => context.read<AdminAuthorsCubit>().fetchAuthors(), context);
          }
          if (state is AdminAuthorsLoaded) {
            if (state.authors.isEmpty) {
              return AdminTheme.emptyState(t.noAuthorsFound,
                  icon: Icons.person_outline);
            }
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.authors.length,
                  itemBuilder: (context, index) {
                    final author = state.authors[index];
                    final displayName = author.name(isAr);
                    return _AuthorCard(
                      name: displayName,
                      booksCount: author.booksCount,
                      imageUrl: author.imageUrl,
                      t: t,
                      onEdit: () => context.push('/add_edit_author', extra: author),
                      onDelete: () async {
                        final confirmed =
                            await AdminTheme.confirmDelete(context, displayName);
                        if (confirmed && context.mounted) {
                          final deletedAuthor = author;
                          final adminCubit = context.read<AdminAuthorsCubit>();
                          adminCubit.deleteAuthor(author.id);
                          
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.authorDeleted),
                            action: SnackBarAction(
                              label: t.undo,
                              textColor: Colors.yellow,
                              onPressed: () => adminCubit.addAuthor(deletedAuthor),
                            ),
                            backgroundColor: AdminTheme.success,
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
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

class _AuthorCard extends StatelessWidget {
  const _AuthorCard({
    required this.name,
    required this.booksCount,
    required this.imageUrl,
    required this.onEdit,
    required this.onDelete,
    required this.t,
  });

  final String name;
  final int booksCount;
  final String imageUrl;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final AppStrings t;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AdminTheme.radiusCard),
        boxShadow: AdminTheme.cardShadow,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: AdminTheme.primaryLight,
          backgroundImage:
              imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
          child: imageUrl.isEmpty
              ? const Icon(Icons.person,
                  color: AdminTheme.primary, size: 26)
              : null,
        ),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AdminTheme.textPrimary)),
        subtitle: Text('${t.booksLabel}: $booksCount',
            style: const TextStyle(
                color: AdminTheme.textSub, fontSize: 13)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined,
                  color: AdminTheme.primary),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  color: AdminTheme.danger),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
