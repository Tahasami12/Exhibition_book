import 'package:flutter/material.dart';
import 'products_section.dart';

class AuthorDetailsPage extends StatelessWidget {
  const AuthorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Authors"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [


            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/author.png'),
            ),

            const SizedBox(height: 8),


            const Text(
              "Novelist",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),


            const Text(
              "Tess Gunty",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 23),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  5,
                      (index) => const Icon(Icons.star, size: 30, color: Colors.amber),
                ),
                const SizedBox(width: 4),
                const Text("(4.0)", style: TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 22),


            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Gunty was born and raised in South Bend, Indiana.She graduated from the University of Notre Dame with a Bachelor of Arts in English and from New York University.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Products Section (reuse)
            const ProductsSection(),
          ],
        ),
      ),
    );
  }
}