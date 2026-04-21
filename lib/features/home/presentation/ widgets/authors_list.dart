import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../cubit/authors_cubit.dart';
import '../cubit/authors_state.dart';
import '../views/author_details_view.dart';

class AuthorsList extends StatelessWidget {
  const AuthorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 220),
      child: BlocBuilder<AuthorsCubit, AuthorsState>(
        builder: (context, state) {
          if (state is AuthorsLoading || state is AuthorsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthorsError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is AuthorsLoaded) {
            if (state.authors.isEmpty) {
              return const Center(child: Text("No authors found."));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveSpacing(context, 16),
              ),
              itemCount: state.authors.length,
              itemBuilder: (_, i) {
                final author = state.authors[i];
                return GestureDetector(
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
                  child: Container(
                    width: Responsive.responsiveSpacing(context, 120),
                    margin: EdgeInsets.only(
                      right: Responsive.responsiveSpacing(context, 14),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: Responsive.responsiveSpacing(context, 50),
                          backgroundImage: author.imageUrl.startsWith('http')
                              ? NetworkImage(author.imageUrl)
                              : AssetImage(author.imageUrl) as ImageProvider,
                          onBackgroundImageError: (_, __) {},
                        ),
                        SizedBox(
                          height: Responsive.responsiveSpacing(context, 8),
                        ),
                        Text(
                          author.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:
                                Responsive.responsiveFontSize(context, 16),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF121212),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.responsiveSpacing(context, 4),
                        ),
                        Text(
                          '${author.booksCount} books',
                          style: TextStyle(
                            fontSize:
                                Responsive.responsiveFontSize(context, 14),
                            color: const Color(0xFFA6A6A6),
                          ),
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
