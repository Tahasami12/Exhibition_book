import 'package:exhibition_book/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SplasViewBody extends StatefulWidget {
  const SplasViewBody({super.key});

  @override
  State<SplasViewBody> createState() => _SplasViewBodyState();
}

class _SplasViewBodyState extends State<SplasViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation <Offset>slidingAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: slidingAnimation,
            child: GestureDetector(
              onTap: () => context.go('/onboarding'),
              child: Image.asset(
                AssetData.logo,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
