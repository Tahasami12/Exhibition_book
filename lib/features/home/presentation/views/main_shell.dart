import 'package:flutter/material.dart';
import 'package:exhibition_book/features/cart_feature/presentation/views/cart_screen.dart';
import '../../../category/view/category_screen.dart';
import '../../../profile/screens/profile.dart';
import '../views/home_view_body.dart';

class MainShellController {
  static final ValueNotifier<int> currentTab = ValueNotifier<int>(0);

  static void showHome() {
    currentTab.value = 0;
  }

  static void showTab(int index) {
    currentTab.value = index;
  }
}

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
  void initState() {
    super.initState();
    MainShellController.currentTab.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    MainShellController.currentTab.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (!mounted) {
      return;
    }

    if (_currentIndex != MainShellController.currentTab.value) {
      setState(() => _currentIndex = MainShellController.currentTab.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != _currentIndex) {
            MainShellController.showTab(index);
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
              color: _primaryColor,
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
              color: _primaryColor,
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
              color: _primaryColor,
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
              color: _primaryColor,
            ),
            label: "Profile",
          ),
        ],
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
