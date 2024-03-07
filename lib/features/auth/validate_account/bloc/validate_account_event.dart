part of 'validate_account_bloc.dart';

@immutable
sealed class ValidateAccountEvent {}

final class OnValidateAccountButtonClickEvent extends ValidateAccountEvent {
  final String? otp;
  final String? email;

  OnValidateAccountButtonClickEvent({this.otp, this.email});
}

final class OnResendOtpButtonClickEvent extends ValidateAccountEvent {
  final String? email;

  OnResendOtpButtonClickEvent({this.email});
}
