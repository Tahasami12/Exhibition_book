import 'package:exhibition_book/features/admin/data/models/user_model.dart';

abstract class AdminUsersState {}

class AdminUsersInitial extends AdminUsersState {}

class AdminUsersLoading extends AdminUsersState {}

class AdminUsersLoaded extends AdminUsersState {
  final List<UserModel> users;
  AdminUsersLoaded(this.users);
}

class AdminUsersError extends AdminUsersState {
  final String message;
  AdminUsersError(this.message);
}

class AdminUsersActionLoading extends AdminUsersState {}

class AdminUsersActionSuccess extends AdminUsersState {
  final String message;
  AdminUsersActionSuccess(this.message);
}

class AdminUsersActionError extends AdminUsersState {
  final String message;
  AdminUsersActionError(this.message);
}
