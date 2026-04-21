import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/promotion_repository.dart';
import 'package:exhibition_book/features/home/data/models/promotion_model.dart';
import 'admin_promotions_state.dart';

class AdminPromotionsCubit extends Cubit<AdminPromotionsState> {
  final PromotionRepository _repository;

  AdminPromotionsCubit(this._repository) : super(AdminPromotionsInitial());

  Future<void> fetchPromotions() async {
    emit(AdminPromotionsLoading());
    try {
      final promotions = await _repository.getPromotions();
      emit(AdminPromotionsLoaded(promotions));
    } catch (e) {
      emit(AdminPromotionsError(e.toString()));
    }
  }

  Future<void> addPromotion(PromotionModel promotion) async {
    emit(AdminPromotionsActionLoading());
    try {
      await _repository.addPromotion(promotion);
      emit(AdminPromotionsActionSuccess('Promotion added successfully'));
      await fetchPromotions();
    } catch (e) {
      emit(AdminPromotionsActionError(e.toString()));
      await fetchPromotions();
    }
  }

  Future<void> updatePromotion(PromotionModel promotion) async {
    emit(AdminPromotionsActionLoading());
    try {
      await _repository.updatePromotion(promotion);
      emit(AdminPromotionsActionSuccess('Promotion updated successfully'));
      await fetchPromotions();
    } catch (e) {
      emit(AdminPromotionsActionError(e.toString()));
      await fetchPromotions();
    }
  }

  Future<void> deletePromotion(String id) async {
    emit(AdminPromotionsActionLoading());
    try {
      await _repository.deletePromotion(id);
      emit(AdminPromotionsActionSuccess('Promotion deleted successfully'));
      await fetchPromotions();
    } catch (e) {
      emit(AdminPromotionsActionError(e.toString()));
      await fetchPromotions();
    }
  }
}
