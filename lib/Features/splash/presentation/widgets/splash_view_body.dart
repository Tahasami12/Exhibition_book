import 'package:exhibition_book/features/splash/presentation/widgets/on_boarding.dart';
import 'package:exhibition_book/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
      duration: const Duration(seconds: 2),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(animationController);

    animationController.forward();
    slidingAnimation.addListener((){
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [SlideTransition(
        position: slidingAnimation,
        
        child: InkWell(
          onTap: () => Get.off(OnBoarding()),
          child: Image.asset(AssetData.logo)))],
    );
  }
}
