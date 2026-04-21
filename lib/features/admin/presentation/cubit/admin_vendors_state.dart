import 'package:exhibition_book/features/home/data/models/vendor_model.dart';

abstract class AdminVendorsState {}

class AdminVendorsInitial extends AdminVendorsState {}

class AdminVendorsLoading extends AdminVendorsState {}

class AdminVendorsLoaded extends AdminVendorsState {
  final List<VendorModel> vendors;

  AdminVendorsLoaded(this.vendors);
}

class AdminVendorsError extends AdminVendorsState {
  final String message;

  AdminVendorsError(this.message);
}

class AdminVendorsActionLoading extends AdminVendorsState {}

class AdminVendorsActionSuccess extends AdminVendorsState {
  final String message;

  AdminVendorsActionSuccess(this.message);
}

class AdminVendorsActionError extends AdminVendorsState {
  final String message;

  AdminVendorsActionError(this.message);
}
