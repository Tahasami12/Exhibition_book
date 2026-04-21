import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/admin/data/models/user_model.dart';
import 'package:exhibition_book/features/admin/data/repositories/admin_users_repository.dart';
import 'admin_users_state.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  final AdminUsersRepository _repository;

  AdminUsersCubit(this._repository) : super(AdminUsersInitial());

  Future<void> fetchUsers() async {
    emit(AdminUsersLoading());
    try {
      final users = await _repository.getAllUsers();
      emit(AdminUsersLoaded(users));
    } catch (e) {
      emit(AdminUsersError(e.toString()));
    }
  }

  Future<void> changeRole(String uid, String newRole) async {
    emit(AdminUsersActionLoading());
    try {
      await _repository.changeUserRole(uid, newRole);
      emit(AdminUsersActionSuccess('Role updated to $newRole'));
      await fetchUsers();
    } catch (e) {
      emit(AdminUsersActionError(e.toString()));
      await fetchUsers();
    }
  }

  Future<void> deleteUser(String uid) async {
    emit(AdminUsersActionLoading());
    try {
      await _repository.deleteUser(uid);
      emit(AdminUsersActionSuccess('User record deleted successfully'));
      await fetchUsers();
    } catch (e) {
      emit(AdminUsersActionError(e.toString()));
      await fetchUsers();
    }
  }
}
