import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/vendor_repository.dart';
import 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  final VendorRepository _repository;

  VendorsCubit(this._repository) : super(VendorsInitial());

  Future<void> fetchVendors() async {
    emit(VendorsLoading());
    try {
      final vendors = await _repository.getAllVendors();
      emit(VendorsLoaded(vendors));
    } catch (e) {
      emit(VendorsError(e.toString()));
    }
  }
}
