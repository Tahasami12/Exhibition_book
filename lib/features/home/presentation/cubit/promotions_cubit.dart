import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/promotion_repository.dart';
import 'promotions_state.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  final PromotionRepository _repository;

  PromotionsCubit(this._repository) : super(PromotionsInitial());
  StreamSubscription? _subscription;

  Future<void> fetchPromotions() async {
    emit(PromotionsLoading());
    _subscription?.cancel();
    _subscription = _repository.getPromotionsStream().listen(
      (promotions) => emit(PromotionsLoaded(promotions)),
      onError: (e) => emit(PromotionsError(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
