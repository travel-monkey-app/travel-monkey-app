part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

final class OnUserProfilePageOpenEvent extends UserProfileEvent {
  final String? username;

  OnUserProfilePageOpenEvent({this.username});
}
