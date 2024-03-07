part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {
  final UserRegirationnModel userRegirationnModel;

  RegistrationSuccess(this.userRegirationnModel);
}

final class RegistrationFailure extends RegistrationState {
  final String? message;

  RegistrationFailure({this.message});
}

final class RegistrationValidationError extends RegistrationState {
  final String? message;
  final ValidationErrorModel? validationErrorModel;

  RegistrationValidationError({this.message, this.validationErrorModel});
}


// Path: lib/features/auth/registration/bloc/registration_state.dart
