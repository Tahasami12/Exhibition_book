import 'package:flutter/material.dart';

import 'author_item.dart';

class AuthorsListVertical extends StatelessWidget {
  const AuthorsListVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 32),
      itemBuilder: (_, i) => const AuthorItem(),
    );
  }
}