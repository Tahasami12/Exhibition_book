import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_books_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_books_state.dart';

class BooksAdminView extends StatefulWidget {
  const BooksAdminView({super.key});

  @override
  State<BooksAdminView> createState() => _BooksAdminViewState();
}

class _BooksAdminViewState extends State<BooksAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBooksCubit>().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: 'Manage Books',
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Book',
            onPressed: () => context.push('/add_edit_book'),
          ),
        ],
      ),
      body: BlocConsumer<AdminBooksCubit, AdminBooksState>(
        listener: (context, state) {
          if (state is AdminBooksActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AdminTheme.success,
              behavior: SnackBarBehavior.floating,
            ));
          } else if (state is AdminBooksActionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message,
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: AdminTheme.danger,
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        buildWhen: (_, current) =>
            current is AdminBooksLoading ||
            current is AdminBooksLoaded ||
            current is AdminBooksError,
        builder: (context, state) {
          if (state is AdminBooksLoading) {
            return Center(
                child: CircularProgressIndicator(
                    color: AdminTheme.primary));
          }
          if (state is AdminBooksError) {
            return AdminTheme.errorState(state.message,
                () => context.read<AdminBooksCubit>().fetchBooks());
          }
          if (state is AdminBooksLoaded) {
            if (state.books.isEmpty) {
              return AdminTheme.emptyState('No books found.',
                  icon: Icons.book_outlined);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return _BookCard(
                  title: book.title,
                  price: book.price,
                  stock: book.stock,
                  imageUrl: book.imageUrl,
                  onEdit: () => context.push('/add_edit_book', extra: book),
                  onDelete: () async {
                    final confirmed = await AdminTheme.confirmDelete(
                        context, book.title);
                    if (confirmed && context.mounted) {
                      context
                          .read<AdminBooksCubit>()
                          .deleteBook(book.id);
                    }
                  },
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

class _BookCard extends StatelessWidget {
  const _BookCard({
    required this.title,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final double price;
  final int stock;
  final String imageUrl;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl,
                  width: 52, height: 64, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.book, size: 52))
              : const Icon(Icons.book, size: 52,
                  color: AdminTheme.primary),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AdminTheme.textPrimary)),
        subtitle: Text(
          '\$${price.toStringAsFixed(2)}  •  Stock: $stock',
          style: const TextStyle(
              color: AdminTheme.textSub, fontSize: 13),
        ),
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
