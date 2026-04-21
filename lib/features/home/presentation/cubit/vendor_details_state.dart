import '../../data/models/vendor_model.dart';

abstract class VendorDetailsState {}

class VendorDetailsInitial extends VendorDetailsState {}

class VendorDetailsLoading extends VendorDetailsState {}

class VendorDetailsSuccess extends VendorDetailsState {
  VendorDetailsSuccess(this.vendor);

  final VendorModel vendor;
}

class VendorDetailsError extends VendorDetailsState {
  VendorDetailsError(this.message);

  final String message;
}
