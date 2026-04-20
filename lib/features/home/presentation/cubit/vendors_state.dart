import '../../data/models/vendor_model.dart';

abstract class VendorsState {}

class VendorsInitial extends VendorsState {}

class VendorsLoading extends VendorsState {}

class VendorsLoaded extends VendorsState {
  final List<VendorModel> vendors;
  VendorsLoaded(this.vendors);
}

class VendorsError extends VendorsState {
  final String message;
  VendorsError(this.message);
}
