part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthUserCreationEvent extends AuthEvent {
  final String email;
  final String password;

  AuthUserCreationEvent({required this.email, required this.password});
}

class AuthUserEmailVerificationEvent extends AuthEvent {}

class AuthUserLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthUserLoginEvent({required this.email, required this.password});
}

class AuthUserGoogleLoginEvent extends AuthEvent {}

class AuthUserGoogleCheckEvent extends AuthEvent {}

class AuthUserGoogleLogoutEvent extends AuthEvent {}
