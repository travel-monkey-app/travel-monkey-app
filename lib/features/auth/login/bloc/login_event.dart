part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class OnLoginButtonClickEvent extends LoginEvent {
  final String? username;
  final String? password;

  OnLoginButtonClickEvent({this.username, this.password});
}

final class OnGoogleSignInButtonClickEvent extends LoginEvent {
  final OAuthCredential credential;

  OnGoogleSignInButtonClickEvent({required this.credential});
}
