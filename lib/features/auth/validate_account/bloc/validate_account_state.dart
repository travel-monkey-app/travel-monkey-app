part of 'validate_account_bloc.dart';

@immutable
sealed class ValidateAccountState {}

final class ValidateAccountInitial extends ValidateAccountState {}

final class ValidateAccountLoading extends ValidateAccountState {}

final class ValidateAccountSuccess extends ValidateAccountState {
  final String? message;

  ValidateAccountSuccess({this.message});
}

final class ValidateAccountFailure extends ValidateAccountState {
  final String? errormessage;

  ValidateAccountFailure({this.errormessage});
}

// resend otp states

final class ResendOtpLoading extends ValidateAccountState {}

final class ResendOtpSuccess extends ValidateAccountState {
  final String? message;

  ResendOtpSuccess({this.message});
}

final class ResendOtpFailure extends ValidateAccountState {
  final String? errormessage;

  ResendOtpFailure({this.errormessage});
}
