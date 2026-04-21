import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/vendor_repository.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'admin_vendors_state.dart';

class AdminVendorsCubit extends Cubit<AdminVendorsState> {
  final VendorRepository _vendorRepository;

  AdminVendorsCubit(this._vendorRepository) : super(AdminVendorsInitial());

  Future<void> fetchVendors() async {
    emit(AdminVendorsLoading());
    try {
      final vendors = await _vendorRepository.getAllVendors();
      emit(AdminVendorsLoaded(vendors));
    } catch (e) {
      emit(AdminVendorsError(e.toString()));
    }
  }

  Future<void> addVendor(VendorModel vendor) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.addVendor(vendor);
      emit(AdminVendorsActionSuccess('Vendor added successfully'));
      await fetchVendors();
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
      await fetchVendors();
    }
  }

  Future<void> updateVendor(VendorModel vendor) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.updateVendor(vendor);
      emit(AdminVendorsActionSuccess('Vendor updated successfully'));
      await fetchVendors();
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
      await fetchVendors();
    }
  }

  Future<void> deleteVendor(String id) async {
    emit(AdminVendorsActionLoading());
    try {
      await _vendorRepository.deleteVendor(id);
      emit(AdminVendorsActionSuccess('Vendor deleted successfully'));
      await fetchVendors();
    } catch (e) {
      emit(AdminVendorsActionError(e.toString()));
      await fetchVendors();
    }
  }
}
