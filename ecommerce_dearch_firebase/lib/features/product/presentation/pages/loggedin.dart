import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/landing.dart';
import 'package:ecommerce_dearch_firebase/features/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loggedin extends StatefulWidget {
  Loggedin({super.key});

  @override
  State<Loggedin> createState() => _LoggedinState();
}

class _LoggedinState extends State<Loggedin> {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {},
      builder: (context, state) {
        String? profilePicture;
        if (state is AuthGoogleAuthenticated) {
          profilePicture = state.profilePicture;
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state is AuthGoogleAuthenticated)
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(profilePicture ?? 'assets/login.webp'),
                )
              else
                IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            ],
          ),
          body: Column(
            children: [
              const Center(
                child: Text('logged in'),
              ),
              ElevatedButton(
                  onPressed: () {
                    auth.signout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LandingPage()));
                  },
                  child: const Text('Sign Out')),
            ],
          ),
        );
      },
    );
  }
}
