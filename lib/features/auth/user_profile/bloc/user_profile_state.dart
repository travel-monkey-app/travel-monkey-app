part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserProfilemodel? userProfilemodel;

  UserProfileSuccess({this.userProfilemodel});
}

final class UserProfileFailure extends UserProfileState {
  final String? errorMessage;

  UserProfileFailure({this.errorMessage});
}
