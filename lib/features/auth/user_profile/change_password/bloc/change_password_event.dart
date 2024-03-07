part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent {}

class OnChangePasswordbuttonEventClick extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  OnChangePasswordbuttonEventClick({
    required this.oldPassword,
    required this.newPassword,
  });
}
