part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}

final class OnResetPasswordButtonClickEvent extends ResetPasswordEvent {
  final String? email;

  OnResetPasswordButtonClickEvent({this.email});
}
