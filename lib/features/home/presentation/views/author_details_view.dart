import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/author_repository.dart';
import '../../data/models/author_model.dart';
import '../cubit/author_details_cubit.dart';
import '../cubit/author_details_state.dart';

class AuthorDetailsView extends StatelessWidget {
  const AuthorDetailsView({
    super.key,
    required this.authorId,
    this.initialAuthor,
  });

  final String authorId;
  final AuthorModel? initialAuthor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthorDetailsCubit(context.read<AuthorRepository>());
        cubit.fetchAuthorDetails(authorId);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Author Details'),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthorDetailsCubit, AuthorDetailsState>(
          builder: (context, state) {
            if (state is AuthorDetailsLoading || state is AuthorDetailsInitial) {
              if (initialAuthor != null) {
                return _AuthorDetailsBody(author: initialAuthor!);
              }
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthorDetailsError) {
              return _DetailsErrorState(
                message: state.message,
                onRetry: () {
                  context.read<AuthorDetailsCubit>().fetchAuthorDetails(authorId);
                },
              );
            }

            if (state is AuthorDetailsSuccess) {
              return _AuthorDetailsBody(author: state.author);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _AuthorDetailsBody extends StatelessWidget {
  const _AuthorDetailsBody({required this.author});

  final AuthorModel author;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: _AuthorImage(imageUrl: author.imageUrl),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              author.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: _InfoChip(
              icon: Icons.menu_book_rounded,
              label: '${author.booksCount} books',
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Biography',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            child: Text(
              author.bio.isEmpty ? 'No biography added yet.' : author.bio,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Author Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            child: Column(
              children: [
                _DetailsRow(label: 'Name', value: author.name),
                const SizedBox(height: 12),
                _DetailsRow(
                  label: 'Books Count',
                  value: author.booksCount.toString(),
                ),
                const SizedBox(height: 12),
                _DetailsRow(label: 'Document ID', value: author.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthorImage extends StatelessWidget {
  const _AuthorImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const Icon(Icons.person, size: 60);
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 60),
      );
    }

    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 60),
    );
  }
}

class _DetailsErrorState extends StatelessWidget {
  const _DetailsErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF54408C)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
