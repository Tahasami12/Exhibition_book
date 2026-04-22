import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/cart_feature/presentation/views/cart_screen.dart';
import 'package:exhibition_book/core/cubit/locale_cubit.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
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
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

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
    if (!mounted) return;
    if (_currentIndex != MainShellController.currentTab.value) {
      setState(() => _currentIndex = MainShellController.currentTab.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAr = context.watch<LocaleCubit>().state.isArabic;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      
      // We pass `isAr` as a ValueKey so the wrapper completely rebuilds from scratch
      // and resets the internal controller whenever the language toggles.
      // This prevents the "double tap" offset bugs tied to the old controller.
      bottomNavigationBar: _MotionTabBarWrapper(
        key: ValueKey<bool>(isAr),
        currentIndex: _currentIndex,
        onTabChanged: (val) {
          MainShellController.showTab(val);
        },
      ),
    );
  }
}

/// A wrapper to isolate MotionTabBar's broken RTL behavior.
/// This cleanly forces LTR rendering but manually swaps the arrays to mimic RTL visually!
class _MotionTabBarWrapper extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  const _MotionTabBarWrapper({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  State<_MotionTabBarWrapper> createState() => _MotionTabBarWrapperState();
}

class _MotionTabBarWrapperState extends State<_MotionTabBarWrapper> with TickerProviderStateMixin {
  late MotionTabBarController _controller;

  @override
  void initState() {
    super.initState();
    final isAr = context.read<LocaleCubit>().state.isArabic;
    final internalIndex = isAr ? 3 - widget.currentIndex : widget.currentIndex;

    _controller = MotionTabBarController(
      initialIndex: internalIndex,
      length: 4,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_MotionTabBarWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isAr = context.read<LocaleCubit>().state.isArabic;
    final internalIndex = isAr ? 3 - widget.currentIndex : widget.currentIndex;
    if (_controller.index != internalIndex) {
      _controller.index = internalIndex;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isAr = context.watch<LocaleCubit>().state.isArabic;

    List<String> labels = [t.navHome, t.navCategory, t.navCart, t.navProfile];
    List<IconData> icons = const [
      Icons.home_outlined,
      Icons.grid_view_outlined,
      Icons.shopping_cart_outlined,
      Icons.person_outline,
    ];

    // Workaround: Since motion_tab_bar_v2 animations break in actual RTL mode,
    // we force it to paint in LTR, but manually reverse the lists so it looks completely right!
    if (isAr) {
      labels = labels.reversed.toList();
      icons = icons.reversed.toList();
    }

    final internalIndex = isAr ? 3 - widget.currentIndex : widget.currentIndex;

    return Directionality(
      textDirection: TextDirection.ltr, // Safely bypass RTL bugs
      child: MotionTabBar(
        controller: _controller,
        initialSelectedTab: labels[internalIndex],
        useSafeArea: true,
        labels: labels,
        icons: icons,
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF54408C),
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.grey,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: const Color(0xFF54408C),
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          final realIndex = isAr ? 3 - value : value;
          widget.onTabChanged(realIndex);
        },
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();
  @override
  Widget build(BuildContext context) => const HomeViewBody();
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody();
  @override
  Widget build(BuildContext context) => const CategoryScreen();
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();
  @override
  Widget build(BuildContext context) => const Profile();
}
