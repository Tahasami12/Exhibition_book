import 'package:exhibition_book/features/auth/data/auth_repository.dart';
import 'package:exhibition_book/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> signUp({required String name, required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authRepository.signUpWithEmailPassword(email, password, name);
      if (userCredential.user != null) {
        String role = await _authRepository.getUserRole(userCredential.user!.uid);
        await CacheHelper.saveUserData(uid: userCredential.user!.uid, role: role);
        emit(AuthSuccess(user: userCredential.user!, role: role));
      } else {
        emit(AuthFailure(errorMessage: 'Unknown error occurred'));
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: _handleError(e)));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authRepository.signInWithEmailPassword(email, password);
      if (userCredential.user != null) {
        String role = await _authRepository.getUserRole(userCredential.user!.uid);
        await CacheHelper.saveUserData(uid: userCredential.user!.uid, role: role);
        emit(AuthSuccess(user: userCredential.user!, role: role));
      } else {
        emit(AuthFailure(errorMessage: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: _handleError(e)));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final userCredential = await _authRepository.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        String role = await _authRepository.getUserRole(userCredential.user!.uid);
        await CacheHelper.saveUserData(uid: userCredential.user!.uid, role: role);
        emit(AuthSuccess(user: userCredential.user!, role: role));
      } else {
        emit(AuthFailure(errorMessage: 'Google Sign In was canceled.'));
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: _handleError(e)));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    await CacheHelper.clearData();
    emit(AuthInitial());
  }

  String _handleError(Object error) {
    String msg = error.toString();
    if (msg.contains('invalid-credential') || msg.contains('user-not-found') || msg.contains('wrong-password')) {
       return 'Invalid email or password.';
    } else if (msg.contains('email-already-in-use')) {
       return 'The email is already registered, try logging in.';
    }
    return msg;
  }
}
