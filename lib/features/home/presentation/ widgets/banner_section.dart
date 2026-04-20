import 'package:exhibition_book/features/home/data/models/promotion_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../cubit/promotions_cubit.dart';
import '../cubit/promotions_state.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  int currentIndex = 0;
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionsCubit, PromotionsState>(
      builder: (context, state) {
        if (state is PromotionsLoading || state is PromotionsInitial) {
          return SizedBox(
            height: Responsive.responsiveSpacing(context, 150),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is PromotionsError) {
          return SizedBox(
            height: Responsive.responsiveSpacing(context, 150),
            child: Center(child: Text("Error: ${state.message}")),
          );
        } else if (state is PromotionsLoaded) {
          final promotions = state.promotions;
          if (promotions.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              SizedBox(
                height: Responsive.responsiveSpacing(context, 150),
                child: PageView.builder(
                  controller: controller,
                  itemCount: promotions.length,
                  onPageChanged: (i) => setState(() => currentIndex = i),
                  itemBuilder: (_, i) => _BannerCard(promotion: promotions[i]),
                ),
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(promotions.length, (i) {
                  final active = i == currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: Responsive.responsiveSpacing(context, 3),
                    ),
                    width:
                        active
                            ? Responsive.responsiveSpacing(context, 18)
                            : Responsive.responsiveSpacing(context, 6),
                    height: Responsive.responsiveSpacing(context, 6),
                    decoration: BoxDecoration(
                      color:
                          active
                              ? const Color(0xFF54408C)
                              : const Color(0xFF54408C).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _BannerCard extends StatelessWidget {
  final PromotionModel promotion;
  const _BannerCard({required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 16),
      ),
      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9FD),
        borderRadius: BorderRadius.circular(
          Responsive.responsiveSpacing(context, 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotion.title,
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 20),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF121212),
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 4)),
                Text(
                  promotion.discount,
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 14),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.responsiveSpacing(context, 18),
                      vertical: Responsive.responsiveSpacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5ECF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.responsiveFontSize(context, 14),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.responsiveSpacing(context, 10)),
          Container(
            width: Responsive.responsiveSpacing(context, 120),
            height: Responsive.responsiveSpacing(context, 120),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(promotion.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
