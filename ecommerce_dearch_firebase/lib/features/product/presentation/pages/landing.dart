// In landing.dart
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/home.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/login.dart';
import 'package:ecommerce_dearch_firebase/features/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedIndex = 0;
  final auth = AuthService();
  final List<Widget> _pages = [HomePage(), LoginPage()];
  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    // print("LandingPage context authBloc: ${context.read<AuthBloc>().state}");

    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        // print('Listener of landing page state is $state');
        // if (state is AuthGoogleAuthenticated) {
        //   print('Profile picture is ${state.profilePicture}');
        // }else if(state is AuthGoogleUnAuthenticated){
        //   print('Unauthenticated state in landing page');
        // }
      },
      builder: (context, state) {
        String? profilePicture;
        print(profilePicture);
        if (state is AuthGoogleAuthenticated) {
          profilePicture = state.profilePicture;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('E-Commerce'),
            centerTitle: true,
            actions: [
              if (state is AuthGoogleAuthenticated)
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Sign out'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () async {
                                    await auth.signout();
                                    context
                                        .read<AuthBloc>()
                                        .add(AuthUserGoogleCheckEvent());
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('yes'))
                            ],
                          );
                        });
                  },
                  child: CircleAvatar(backgroundImage: profilePicture != null? NetworkImage(profilePicture) : null,
                    child: profilePicture == null
                        ? const Icon(Icons.person) 
                        : null,
                  ),
                )
              else
                IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            ],
          ),
          body: _pages[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              currentIndex: selectedIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_sharp), label: 'Profile')
              ]),
        );
      },
    );
  }
}
