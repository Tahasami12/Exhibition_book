import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/vendor_repository.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'admin_vendors_state.dart';

class AdminVendorsCubit extends Cubit<AdminVendorsState> {
  final VendorRepository _vendorRepository;

  AdminVendorsCubit(this._vendorRepository) : super(AdminVendorsInitial());
  StreamSubscription? _subscription;

  Future<void> fetchVendors() async {
    emit(AdminVendorsLoading());
    _subscription?.cancel();
    _subscription = _vendorRepository.getVendorsStream().listen(
      (vendors) => emit(AdminVendorsLoaded(vendors)),
      onError: (e) => emit(AdminVendorsError(e.toString())),
    );
  }

  Future<void> addVendor(VendorModel vendor) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.addVendor(vendor);
      emit(AdminVendorsActionSuccess('Vendor added successfully'));
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
    }
  }

  Future<void> updateVendor(VendorModel vendor) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.updateVendor(vendor);
      emit(AdminVendorsActionSuccess('Vendor updated successfully'));
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
    }
  }

  Future<void> deleteVendor(String id) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.deleteVendor(id);
      emit(AdminVendorsActionSuccess('Vendor deleted successfully'));
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
