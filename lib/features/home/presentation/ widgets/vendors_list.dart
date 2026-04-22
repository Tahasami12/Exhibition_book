import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/vendor_model.dart';
import '../cubit/vendors_cubit.dart';
import '../cubit/vendors_state.dart';
import '../../../../core/utils/responsive.dart';
import '../views/vendor_details_view.dart';

class VendorsList extends StatelessWidget {
  const VendorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final listHeight = Responsive.responsiveSpacing(
      context,
      126,
      tabletSpacing: 146,
      desktopSpacing: 160,
    );

    return SizedBox(
      height: listHeight,
      child: BlocBuilder<VendorsCubit, VendorsState>(
        builder: (context, state) {
          if (state is VendorsLoading || state is VendorsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VendorsError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is VendorsLoaded) {
            if (state.vendors.isEmpty) {
              return const Center(child: Text("No vendors found."));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveSpacing(context, 16),
              ),
              itemCount: state.vendors.length,
              itemBuilder: (_, i) {
                final vendor = state.vendors[i];
                return GestureDetector(
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
                  child: Container(
                    width: Responsive.responsiveSpacing(
                      context,
                      96,
                      tabletSpacing: 110,
                      desktopSpacing: 120,
                    ),
                    margin: EdgeInsets.only(
                      right: Responsive.responsiveSpacing(context, 10),
                    ),
                    child: _VendorHomeCard(vendor: vendor),
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

class _VendorHomeCard extends StatelessWidget {
  const _VendorHomeCard({required this.vendor});

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      Responsive.responsiveSpacing(context, 12),
    );
    final verticalGap = Responsive.responsiveSpacing(context, 8);
    final nameStyle = TextStyle(
      fontSize: Responsive.responsiveFontSize(context, 12),
      fontWeight: FontWeight.w600,
      color: const Color(0xFF121212),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = constraints.maxWidth.clamp(72.0, 110.0).toDouble();

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              padding: EdgeInsets.all(
                Responsive.responsiveSpacing(context, 10),
              ),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: _VendorLogo(logoUrl: vendor.logoUrl),
                  ),
                ),
              ),
            ),
            SizedBox(height: verticalGap),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  vendor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: nameStyle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VendorLogo extends StatelessWidget {
  const _VendorLogo({required this.logoUrl});

  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    if (logoUrl.startsWith('http')) {
      return Image.network(
        logoUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.store),
      );
    }

    return Image.asset(
      logoUrl,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(Icons.store),
    );
  }
}
