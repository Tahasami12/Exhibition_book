import 'package:flutter/material.dart';

import '../ widgets/authorslistvertical.dart';
import '../ widgets/authorstabs.dart';

class AuthorsView extends StatelessWidget {
  const AuthorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 80,
                child: Stack(
                  children: [

                    Positioned(
                      top: 26,
                      left: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),


                    const Positioned(
                      top: 32,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Authors",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),


                    const Positioned(
                      top: 34,
                      right: 0,
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),


            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Check the authors",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA6A6A6),
                ),
              ),
            ),

            const SizedBox(height: 2),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Authors",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.35,
                  letterSpacing: -0.3,
                  color: Color(0xFF54408C),
                ),
              ),
            ),

            const SizedBox(height: 20),


            const AuthorsTabs(),

            const SizedBox(height: 18),


            const Expanded(
              child: AuthorsListVertical(),
            ),
          ],
        ),
      ),
    );
  }
}