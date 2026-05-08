import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/vendor_repository.dart';
import 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  final VendorRepository _repository;

  VendorsCubit(this._repository) : super(VendorsInitial());
  StreamSubscription? _subscription;

  Future<void> fetchVendors() async {
    emit(VendorsLoading());
    _subscription?.cancel();
    _subscription = _repository.getVendorsStream().listen(
      (vendors) => emit(VendorsLoaded(vendors)),
      onError: (e) => emit(VendorsError(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
