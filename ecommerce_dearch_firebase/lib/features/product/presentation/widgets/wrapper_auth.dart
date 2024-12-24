import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/email_verification.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/landing.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/loggedin.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapperAuth extends StatefulWidget {
  const WrapperAuth({super.key});

  @override
  State<WrapperAuth> createState() => _WrapperAuthState();
}

class _WrapperAuthState extends State<WrapperAuth> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGoogleAuthenticated) {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => LandingPage()));
        } else if (state is AuthGoogleUnAuthenticated) {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => LandingPage()));
        }else if(state is AuthUserEmailVerificationSuccessState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => Loggedin()));
        }
      },
      builder: (context, state) {
        if (state is AuthLoginLoadingState) {
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
        }
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Hass error'),
                );
              } else {
                if (snapshot.data == null) {
                  return LoginPage();
                } else {
                  if (snapshot.data?.emailVerified == true) {
                    return Loggedin();
                  } else {
                    return const EmailVerificationScreen();
                  }
                }
              }
            });
      },
    );
  }
}
