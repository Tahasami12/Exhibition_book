import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';


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
    return Column(
      children: [
        SizedBox(
          height: Responsive.responsiveSpacing(context, 150),
          child: PageView.builder(
            controller: controller,
            itemCount: 3,
            onPageChanged: (i) => setState(() => currentIndex = i),
            itemBuilder: (_, i) =>  _BannerCard(),
          ),
        ),

        SizedBox(height: Responsive.responsiveSpacing(context, 10)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final active = i == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveSpacing(context, 3),
              ),
              width: active
                  ? Responsive.responsiveSpacing(context, 18)
                  : Responsive.responsiveSpacing(context, 6),
              height: Responsive.responsiveSpacing(context, 6),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF54408C)
                    : const Color(0xFF54408C).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 16),
      ),
      padding: EdgeInsets.all(
        Responsive.responsiveSpacing(context, 16),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9FD),
        borderRadius: BorderRadius.circular(
          Responsive.responsiveSpacing(context, 16),
        ),


        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                  'Special Offer',
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 20),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF121212),
                  ),
                ),

                SizedBox(
                  height: Responsive.responsiveSpacing(context, 4),
                ),

                Text(
                  'Discount 25%',
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 14),
                    color: Colors.grey,
                  ),
                ),

                SizedBox(
                  height: Responsive.responsiveSpacing(context, 12),
                ),


                InkWell(
                  onTap: () {

                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      Responsive.responsiveSpacing(context, 18),
                      vertical:
                      Responsive.responsiveSpacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5ECF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                        Responsive.responsiveFontSize(context, 14),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: Responsive.responsiveSpacing(context, 10),
          ),


          Container(
            width: Responsive.responsiveSpacing(context, 120),
            height: Responsive.responsiveSpacing(context, 120),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/book.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}