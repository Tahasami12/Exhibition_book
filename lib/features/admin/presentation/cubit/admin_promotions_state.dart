import 'package:exhibition_book/features/home/data/models/promotion_model.dart';

abstract class AdminPromotionsState {}

class AdminPromotionsInitial extends AdminPromotionsState {}

class AdminPromotionsLoading extends AdminPromotionsState {}

class AdminPromotionsLoaded extends AdminPromotionsState {
  final List<PromotionModel> promotions;
  AdminPromotionsLoaded(this.promotions);
}

class AdminPromotionsError extends AdminPromotionsState {
  final String message;
  AdminPromotionsError(this.message);
}

class AdminPromotionsActionLoading extends AdminPromotionsState {}

class AdminPromotionsActionSuccess extends AdminPromotionsState {
  final String message;
  AdminPromotionsActionSuccess(this.message);
}

class AdminPromotionsActionError extends AdminPromotionsState {
  final String message;
  AdminPromotionsActionError(this.message);
}
