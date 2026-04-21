import 'package:flutter/material.dart';
import 'package:exhibition_book/features/cart_feature/presentation/views/cart_screen.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import '../../../category/view/category_screen.dart';
import '../../../profile/screens/profile.dart';
import '../views/home_view_body.dart';

/// Main shell that holds all four tab screens in an IndexedStack.
/// This ensures the CartCubit state from BlocProvider persists across
/// tab switches because all screens share the same widget tree.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const _primaryColor = Color(0xFF54408C);

  // All tab screens are created once and kept alive via IndexedStack
  final List<Widget> _screens = const [
    _HomeBody(),
    _CategoryBody(),
    CartScreen(),
    _ProfileBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: const ["Home", "Category", "Cart", "Profile"],
        icons: const [
          Icons.home_outlined,
          Icons.grid_view_outlined,
          Icons.shopping_cart_outlined,
          Icons.person_outline,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: _primaryColor,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.grey,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: _primaryColor,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          if (value != _currentIndex) {
            setState(() {
              _currentIndex = value;
            });
          }
        },
      ),
    );
  }
}

/// Wrapper that renders the Home screen body without its own Scaffold/BottomNav.
/// The Scaffold + BottomNav are now owned by MainShell.
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return const HomeViewBody();
  }
}

/// Wrapper that renders the Category screen body.
class _CategoryBody extends StatelessWidget {
  const _CategoryBody();

  @override
  Widget build(BuildContext context) {
    return const CategoryScreen();
  }
}

/// Wrapper that renders the Profile screen body.
class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return const Profile();
  }
}
