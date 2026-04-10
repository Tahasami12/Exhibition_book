import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../views/vendors_view.dart';

class VendorsList extends StatelessWidget {
  const VendorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 90),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveSpacing(context, 16),
        ),
        itemCount: 6,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VendorsView(),
                ),
              );
            },
            child: Container(
              width: Responsive.responsiveSpacing(context, 90),
              margin: EdgeInsets.only(
                right: Responsive.responsiveSpacing(context, 3),

              ),
              child: Column(
                children: [

                  Container(
                    height: Responsive.responsiveSpacing(context, 80),
                    width: Responsive.responsiveSpacing(context, 80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Responsive.responsiveSpacing(context, 12),
                      ),
                      color: Colors.grey[100],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        Responsive.responsiveSpacing(context, 12),
                      ),
                      child: Image.asset(
                        'assets/images/vendor.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Responsive.responsiveSpacing(context, 4),
                  ),



                ],
              ),
            ),
          );
        },
      ),
    );
  }
}