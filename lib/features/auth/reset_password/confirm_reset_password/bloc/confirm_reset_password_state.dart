part of 'confirm_reset_password_bloc.dart';

@immutable
sealed class ConfirmResetPasswordState {}

final class ConfirmResetPasswordInitial extends ConfirmResetPasswordState {}

final class ConfirmResetPasswordLoading extends ConfirmResetPasswordState {}

final class ConfirmResetPasswordSuccess extends ConfirmResetPasswordState {
  final String? message;

  ConfirmResetPasswordSuccess({this.message});
}

final class ConfirmResetPasswordFailure extends ConfirmResetPasswordState {
  final String? errorMessage;

  ConfirmResetPasswordFailure({this.errorMessage});
}
