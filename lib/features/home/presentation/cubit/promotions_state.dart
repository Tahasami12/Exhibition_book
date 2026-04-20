import '../../data/models/promotion_model.dart';

abstract class PromotionsState {}

class PromotionsInitial extends PromotionsState {}

class PromotionsLoading extends PromotionsState {}

class PromotionsLoaded extends PromotionsState {
  final List<PromotionModel> promotions;

  PromotionsLoaded(this.promotions);
}

class PromotionsError extends PromotionsState {
  final String message;

  PromotionsError(this.message);
}
