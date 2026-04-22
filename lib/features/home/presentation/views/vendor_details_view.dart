import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/vendor_repository.dart';
import '../../data/models/vendor_model.dart';
import '../cubit/vendor_details_cubit.dart';
import '../cubit/vendor_details_state.dart';

class VendorDetailsView extends StatelessWidget {
  const VendorDetailsView({
    super.key,
    required this.vendorId,
    this.initialVendor,
  });

  final String vendorId;
  final VendorModel? initialVendor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = VendorDetailsCubit(context.read<VendorRepository>());
        cubit.fetchVendorDetails(vendorId);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vendor Details'),
          centerTitle: true,
        ),
        body: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
          builder: (context, state) {
            if (state is VendorDetailsLoading || state is VendorDetailsInitial) {
              if (initialVendor != null) {
                return _VendorDetailsBody(vendor: initialVendor!);
              }
              return const Center(child: CircularProgressIndicator());
            }

            if (state is VendorDetailsError) {
              return _DetailsErrorState(
                message: state.message,
                onRetry: () {
                  context.read<VendorDetailsCubit>().fetchVendorDetails(vendorId);
                },
              );
            }

            if (state is VendorDetailsSuccess) {
              return _VendorDetailsBody(vendor: state.vendor);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _VendorDetailsBody extends StatelessWidget {
  const _VendorDetailsBody({required this.vendor});

  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: _VendorImage(logoUrl: vendor.logoUrl),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              vendor.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _InfoChip(
                  icon: Icons.star_rounded,
                  label: 'Rating ${vendor.rating.toStringAsFixed(1)}',
                ),
                _InfoChip(
                  icon: vendor.isBestVendor ? Icons.workspace_premium : Icons.store,
                  label: vendor.isBestVendor ? 'Best Vendor' : 'Vendor',
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Vendor Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            child: Column(
              children: [
                _DetailsRow(label: 'Name', value: vendor.name),
                const SizedBox(height: 12),
                _DetailsRow(
                  label: 'Rating',
                  value: vendor.rating.toStringAsFixed(1),
                ),
                const SizedBox(height: 12),
                _DetailsRow(
                  label: 'Featured',
                  value: vendor.isBestVendor ? 'Yes' : 'No',
                ),
                const SizedBox(height: 12),
                _DetailsRow(label: 'Document ID', value: vendor.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorImage extends StatelessWidget {
  const _VendorImage({required this.logoUrl});

  final String logoUrl;

  @override
  Widget build(BuildContext context) {
    if (logoUrl.startsWith('http')) {
      return Image.network(
        logoUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 60),
      );
    }

    return Image.asset(
      logoUrl,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 60),
    );
  }
}

class _DetailsErrorState extends StatelessWidget {
  const _DetailsErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF54408C)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DetailsRow extends StatelessWidget {
  const _DetailsRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
