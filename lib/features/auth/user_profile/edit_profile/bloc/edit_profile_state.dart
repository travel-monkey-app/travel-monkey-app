part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  final String? message;

  EditProfileSuccess({this.message});
}

final class EditProfileFailure extends EditProfileState {
  final String? errorMessage;

  EditProfileFailure({this.errorMessage});
}
