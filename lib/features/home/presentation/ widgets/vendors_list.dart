import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vendors_cubit.dart';
import '../cubit/vendors_state.dart';

import '../../../../core/utils/responsive.dart';
import '../views/vendors_view.dart';

class VendorsList extends StatelessWidget {
  const VendorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveSpacing(context, 90),
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
                            border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveSpacing(context, 12),
                            ),
                            child: Image.network(
                              vendor.logoUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.store),
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}