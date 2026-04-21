import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authors_cubit.dart';
import '../cubit/authors_state.dart';
import '../views/author_details_view.dart';

class AuthorsListVertical extends StatelessWidget {
  const AuthorsListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorsCubit, AuthorsState>(
      builder: (context, state) {
        if (state is AuthorsLoading || state is AuthorsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AuthorsError) {
          return Center(child: Text(state.message));
        }

        if (state is AuthorsLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: state.authors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 32),
            itemBuilder: (_, i) {
              final author = state.authors[i];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthorDetailsView(
                        authorId: author.id,
                        initialAuthor: author,
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage: author.imageUrl.startsWith('http')
                          ? NetworkImage(author.imageUrl)
                          : AssetImage(author.imageUrl) as ImageProvider,
                      onBackgroundImageError: (_, __) {},
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            author.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1.35,
                              letterSpacing: -0.3,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            author.bio.isEmpty
                                ? '${author.booksCount} books available'
                                : author.bio,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Color(0xFFA6A6A6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
