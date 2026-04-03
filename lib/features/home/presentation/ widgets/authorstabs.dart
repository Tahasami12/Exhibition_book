import 'package:flutter/material.dart';
class AuthorsTabs extends StatelessWidget {
  const AuthorsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          _TabItem("All", active: true),
          _TabItem("Poets"),
          _TabItem("Playwrights"),
          _TabItem("Novelists"),
          _TabItem("Journalists"),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool active;

  const _TabItem(this.title, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              color: active ? Colors.black : Colors.grey,
            ),
          ),

          const SizedBox(height: 4),


          Container(
            height: 2,
            width: active ? 20 : 0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}