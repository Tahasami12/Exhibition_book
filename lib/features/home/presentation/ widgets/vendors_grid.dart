import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/vendors_cubit.dart';
import '../cubit/vendors_state.dart';
import '../views/vendor_details_view.dart';

class VendorsGrid extends StatelessWidget {
  const VendorsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<VendorsCubit, VendorsState>(
        builder: (context, state) {
          if (state is VendorsLoading || state is VendorsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VendorsError) {
            return Center(child: Text(state.message));
          }

          if (state is VendorsLoaded) {
            return GridView.builder(
              itemCount: state.vendors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.responsiveGridCount(context),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 101 / 153,
              ),
              itemBuilder: (_, i) {
                final vendor = state.vendors[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VendorDetailsView(
                          vendorId: vendor.id,
                          initialVendor: vendor,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Responsive.responsiveSpacing(context, 101),
                        width: Responsive.responsiveSpacing(context, 101),
                        padding: EdgeInsets.all(
                          Responsive.responsiveSpacing(context, 12),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: vendor.logoUrl.startsWith('http')
                              ? Image.network(
                                  vendor.logoUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.store),
                                )
                              : Image.asset(
                                  vendor.logoUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.store),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        vendor.name(AppStrings.isArabic(context)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 16),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF121212),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: Responsive.responsiveIconSize(context, 16),
                            color: const Color(0xFFFFC107),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            vendor.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize:
                                  Responsive.responsiveFontSize(context, 13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
