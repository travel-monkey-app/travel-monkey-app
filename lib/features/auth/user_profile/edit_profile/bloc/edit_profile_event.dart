part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class OnEditProfileButtonClickEvent extends EditProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? profilePicPath;

  OnEditProfileButtonClickEvent(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicPath});
}
