import 'package:flutter/material.dart';

import '../../../category/view/category_screen.dart';
import '../../../profile/screens/profile.dart';
import 'package:exhibition_book/features/cart_feature/presentation/views/cart_screen.dart';
import '../views/home_view.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({super.key, required this.currentIndex});

  static const primaryColor = Color(0xFF54408C);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 10,

      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,

      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeView()),
            );
            break;

          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CategoryScreen()),
            );
            break;

          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CartScreen(),
              ),
            );
            break;

          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>  const Profile(),
              ),
            );
            break;
        }
      },

      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/Home.png'),
            size: 24,
            color: Colors.grey,
          ),
          activeIcon: ImageIcon(
            AssetImage('assets/images/Home.png'),
            size: 24,
            color: Color(0xFF54408C),
          ),
          label: "Home",
        ),

        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/category.png'),
            size: 24,
            color: Colors.grey,
          ),
          activeIcon: ImageIcon(
            AssetImage('assets/images/category.png'),
            size: 24,
            color: Color(0xFF54408C),
          ),
          label: "Category",
        ),

        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/cart.png'),
            size: 24,
            color: Colors.grey,
          ),
          activeIcon: ImageIcon(
            AssetImage('assets/images/cart.png'),
            size: 24,
            color: Color(0xFF54408C),
          ),
          label: "Cart",
        ),

        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/Profile.png'),
            size: 24,
            color: Colors.grey,
          ),
          activeIcon: ImageIcon(
            AssetImage('assets/images/Profile.png'),
            size: 24,
            color: Color(0xFF54408C),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
