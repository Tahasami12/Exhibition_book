import 'package:flutter_bloc/flutter_bloc.dart';

// ─── State ────────────────────────────────────────────────────────────────────
class LocaleState {
  final bool isArabic;
  const LocaleState({this.isArabic = false});
}

// ─── Cubit ────────────────────────────────────────────────────────────────────
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState());

  void toggle() => emit(LocaleState(isArabic: !state.isArabic));
  void setEnglish() => emit(const LocaleState(isArabic: false));
  void setArabic() => emit(const LocaleState(isArabic: true));
}
