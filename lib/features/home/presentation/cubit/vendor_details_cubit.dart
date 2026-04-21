import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/vendor_repository.dart';
import 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  VendorDetailsCubit(this._repository) : super(VendorDetailsInitial());

  final VendorRepository _repository;

  Future<void> fetchVendorDetails(String vendorId) async {
    emit(VendorDetailsLoading());
    try {
      final vendor = await _repository.getVendorById(vendorId);
      emit(VendorDetailsSuccess(vendor));
    } catch (e) {
      emit(VendorDetailsError(e.toString()));
    }
  }
}
