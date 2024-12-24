part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

abstract class AuthActionState extends AuthState {}

class AuthUserCreationLoadingState extends AuthState {}

class AuthUserCreationSuccessActionState extends AuthActionState {}

class AuthUserEmailVerificationLoadingState extends AuthActionState {}

class AuthUserEmailVerificationSuccessState extends AuthActionState {}

class AuthUserCreationFailureActionState extends AuthActionState {
  final String message;

  AuthUserCreationFailureActionState({required this.message});
}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessActionState extends AuthActionState {
  AuthLoginSuccessActionState();
}

class AuthLoginErrorActionState extends AuthActionState {
  final String message;

  AuthLoginErrorActionState({required this.message});
}

class AuthGoogleLoginLoadingActionState extends AuthState {}

class AuthGoogleLoginSuccessActionState extends AuthActionState {}

class AuthGoogleLoginErrorActionState extends AuthActionState {
  final String message;

  AuthGoogleLoginErrorActionState({required this.message});
}

class AuthGoogleAuthenticated extends AuthState {
  final String? profilePicture;

  AuthGoogleAuthenticated({required this.profilePicture});
}

class AuthGoogleUnAuthenticated extends AuthState {}
