import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/responsive.dart';
import '../../home/data/models/book_model.dart';
import '../../home/presentation/cubit/books_cubit.dart';
import '../../home/presentation/cubit/books_state.dart';
import '../../home/presentation/views/book_details_view.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.responsiveSpacing(context, 16),
        Responsive.responsiveSpacing(context, 20),
        Responsive.responsiveSpacing(context, 16),
        0,
      ),
      child: Column(
        children: [
          // ── Header row ──────────────────────────────────────────
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.grey900,
                  size: Responsive.responsiveIconSize(context, 24),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    t.searchHint.replaceAll('...', ''),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.responsiveFontSize(context, 20),
                      color: AppColors.grey900,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Responsive.responsiveSpacing(context, 40)),
            ],
          ),

          SizedBox(height: Responsive.responsiveSpacing(context, 16)),

          // ── Search field ─────────────────────────────────────────
          TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (v) => setState(() => _query = v.trim()),
            decoration: InputDecoration(
              hintText: t.searchHint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: Responsive.responsiveFontSize(context, 14),
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF6C47FF)),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon:
                          Icon(Icons.clear, color: Colors.grey.shade400),
                      onPressed: () {
                        _controller.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.15)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: Color(0xFF6C47FF), width: 1.5),
              ),
            ),
          ),

          SizedBox(height: Responsive.responsiveSpacing(context, 16)),

          // ── Results ───────────────────────────────────────────────
          Expanded(
            child: _query.isEmpty
                ? _EmptyPrompt()
                : _SearchResults(query: _query),
          ),
        ],
      ),
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 72, color: Colors.grey.shade200),
          const SizedBox(height: 12),
          Text(
            AppStrings.of(context).typeToSearch,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final String query;
  const _SearchResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BooksError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is BooksLoaded) {
          final q = query.toLowerCase();
          final List<BookModel> results = state.books
              .where((b) =>
                  b.title.toLowerCase().contains(q) ||
                  b.author.toLowerCase().contains(q) ||
                  b.category.toLowerCase().contains(q))
              .toList();

          if (results.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off,
                      size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text(
                    '${AppStrings.of(context).noBooksFoundFor} "$query"',
                    style: TextStyle(
                        color: Colors.grey.shade500, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final book = results[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BookDetailsPage(book: book)),
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      // Book cover
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.imageUrl,
                          width: 52,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 52,
                            height: 70,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.book, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Book info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              book.author,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C47FF)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    book.category,
                                    style: const TextStyle(
                                      color: Color(0xFF6C47FF),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'EGP ${book.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFF6C47FF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
