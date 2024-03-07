part of 'confirm_reset_password_bloc.dart';

@immutable
sealed class ConfirmResetPasswordEvent {}

final class OnConfirmResetPasswordButtonClickEvent
    extends ConfirmResetPasswordEvent {
  final String? otp;
  final String? email;
  final String? newPassword;
  final String? confirmPassword;

  OnConfirmResetPasswordButtonClickEvent(
      {this.otp, this.newPassword, this.confirmPassword, this.email});
}
