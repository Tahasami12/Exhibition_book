import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/promotion_repository.dart';
import 'promotions_state.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  final PromotionRepository _repository;

  PromotionsCubit(this._repository) : super(PromotionsInitial());

  Future<void> fetchPromotions() async {
    emit(PromotionsLoading());
    try {
      final promotions = await _repository.getPromotions();
      emit(PromotionsLoaded(promotions));
    } catch (e) {
      emit(PromotionsError(e.toString()));
    }
  }
}
