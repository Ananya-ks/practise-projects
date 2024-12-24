import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = AuthService();
  bool isGoogleLoginTriggered = false;
  String? profilePicture;
  AuthBloc() : super(AuthInitial()) {
    on<AuthUserCreationEvent>(authUserCreationEvent);
    on<AuthUserLoginEvent>(authUserLoginEvent);
    on<AuthUserGoogleLoginEvent>(authUserGoogleLoginEvent);
    on<AuthUserGoogleCheckEvent>(authUserGoogleCheckEvent);
    on<AuthUserEmailVerificationEvent>(authUserEmailVerificationEvent);
  }

  FutureOr<void> authUserCreationEvent(
      AuthUserCreationEvent event, Emitter<AuthState> emit) async {
    emit(AuthUserCreationLoadingState());
    if (event.email.isEmpty && event.password.isEmpty) {
      emit(AuthUserCreationFailureActionState(
          message: 'Email and password cannot be empty'));
      return;
    }
    if (event.email.isEmpty) {
      emit(
          AuthUserCreationFailureActionState(message: 'Email cannot be empty'));
      return;
    }
    if (event.password.isEmpty) {
      emit(AuthUserCreationFailureActionState(
          message: 'Password cannot be empty'));
      return;
    }
    try {
      final user = await auth.createUserWithEmailAndpassword(
          event.email, event.password);
      if (user != null) {
        add(AuthUserEmailVerificationEvent());

        emit(AuthUserCreationSuccessActionState());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'weak-password':
          errorMessage = 'The password must be at least 6 characters long.';
          break;
        case 'operation-not-allowed':
          errorMessage =
              'Email/password accounts are not enabled. Contact support.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
      }
      emit(AuthUserCreationFailureActionState(message: errorMessage));
    } catch (e) {
      emit(AuthUserCreationFailureActionState(
          message: 'An unexpected error occurred.'));
    }
  }

  FutureOr<void> authUserLoginEvent(
      AuthUserLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoadingState());
    if (event.email.isEmpty && event.password.isEmpty) {
      emit(AuthLoginErrorActionState(
          message: 'Email and password cannot be empty'));
      return;
    }
    if (event.email.isEmpty) {
      emit(AuthLoginErrorActionState(message: 'Email cannot be empty'));
      return;
    }
    if (event.password.isEmpty) {
      emit(AuthLoginErrorActionState(message: 'Password cannot be empty'));
      return;
    }
    try {
      final user =
          await auth.loginUserWithEmailAndpassword(event.email, event.password);
      if (user != null) {
        isGoogleLoginTriggered = true;
        emit(AuthLoginSuccessActionState());
      }
    } on FirebaseAuthException catch (e) {
      String errorLoginMessage;
      switch (e.code) {
        case 'invalid-email':
          errorLoginMessage = 'The email address is badly formatted';
          break;
        case 'user-disabled':
          errorLoginMessage = 'This account has been disabled.';
          break;
        case 'user-not-found':
          errorLoginMessage = 'No account found with this email.';
          break;
        case 'invalid-credential':
          errorLoginMessage = 'Invalid credentials';
          break;
        case 'too-many-requests':
          errorLoginMessage = 'Too many failed attempts. Try again later.';
          break;
        case 'network-request-failed':
          errorLoginMessage = 'Check your internet connection.';
          break;
        case 'operation-not-allowed':
          errorLoginMessage = 'Login is not allowed. Contact support.';
          break;
        default:
          errorLoginMessage = 'An unknown error occurred. Please try again.';
          print(e.code);
      }
      emit(AuthLoginErrorActionState(message: errorLoginMessage));
    } catch (e) {
      emit(AuthLoginErrorActionState(message: 'Error occured'));
    }
  }

  FutureOr<void> authUserGoogleLoginEvent(
      AuthUserGoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoadingState());
    try {
      final userCred = await auth.loginWithGoogle();
      final user = userCred?.user;
      if (user != null) {
        profilePicture = user.photoURL;
        emit(AuthGoogleAuthenticated(profilePicture: profilePicture));
      } else {
        emit(AuthGoogleUnAuthenticated());
      }
    } catch (e) {
      emit(AuthGoogleUnAuthenticated());
    }
  }

  FutureOr<void> authUserGoogleCheckEvent(
      AuthUserGoogleCheckEvent event, Emitter<AuthState> emit) async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthGoogleAuthenticated(profilePicture: user.photoURL));
    } else {
      emit(AuthGoogleUnAuthenticated());
    }
  }

  FutureOr<void> authUserEmailVerificationEvent(
      AuthUserEmailVerificationEvent event, Emitter<AuthState> emit) async {
    await auth.sendEmailVerificationLink();
    emit(AuthUserEmailVerificationLoadingState());
    bool isEmailVerified = false;
    while (!isEmailVerified) {
      await Future.delayed(const Duration(seconds: 5));
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        isEmailVerified = true;
        emit(AuthUserEmailVerificationSuccessState());
      }
    }
  }
}
