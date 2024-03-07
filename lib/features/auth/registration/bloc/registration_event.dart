part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class OnRegisterButtonClickEvent extends RegistrationEvent {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phonenumber;
  final String confirmPassword;

  OnRegisterButtonClickEvent({
    required this.phonenumber,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
  });
}
