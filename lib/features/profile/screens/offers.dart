import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:exhibition_book/features/home/presentation/cubit/promotions_cubit.dart';
import 'package:exhibition_book/features/home/presentation/cubit/promotions_state.dart';

class Offers extends StatelessWidget {
  Offers({super.key});

  // store the colors in an array to assign them dynamically.
  static final List<Color> offersColors = [
    AppColors.orange,
    AppColors.primary,
    AppColors.blue,
    AppColors.yellow,
    AppColors.textPrimary,
    AppColors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        backgroundColor: AppColors.background,
        appBar: makeAppBar(
          title: "Order History",
          titleColor: AppColors.grey900,
          enableLeading: true,
          barBackgroundColor: AppColors.background,
        ),
        body: BlocBuilder<PromotionsCubit, PromotionsState>(
          builder: (context, state) {
            if (state is PromotionsLoading || state is PromotionsInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is PromotionsError) {
              return Center(child: Text("Failed to load offers: ${state.message}"));
            } else if (state is PromotionsLoaded) {
              final offers = state.promotions;

              if (offers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_offer_outlined, size: 80, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text(
                        "No Offers Available",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),

                      Text(
                        "You Have ${offers.length} Coupons to use",
                        style: TextStyle(
                          color: AppColors.grey900,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: offers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final offerInfo = offers[index];
                          // Create a dummy OfferModel to feed into makeOffers since its UI relies on it
                          // Parsing "20% OFF" or just throwing the discount string 
                          // The `makeOffers` helper expects an OfferModel
                          return _PromoCardFromDb(
                            discount: offerInfo.discount,
                            color: offersColors[index % offersColors.length],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
  }
}

class _PromoCardFromDb extends StatelessWidget {
  final String discount;
  final Color color;

  const _PromoCardFromDb({required this.discount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      width: 155,
      height: 161,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              discount.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.w700,
                fontSize: 24, // reduced font size slightly to fit string like "20% OFF" better
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 92,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  "Copy",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
