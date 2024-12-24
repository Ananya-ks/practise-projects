// import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/signup.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/custom_button.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// TextEditingController -> creates a controller for editable text field. Also gives access to the text, the user types
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();

    /// SingleChildScrollableView -> make a widget scroll when its content overflows out of the page.
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      // listenWhen: (previous, current) => current is AuthActionState,
      // buildWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is AuthLoginErrorActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoginLoadingState) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/login.webp',
                  width: 500.0,
                  height: 300.0,
                ),
                MyTextField(
                  controller: emailController,
                  prefixIconData: Icons.email,
                  prefixIconColor: Colors.blue,
                  hintText: 'Email',
                  obsecureText: false,
                  obscuringCharacter: '/',
                  fontSize: 15.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                  prefixIconData: Icons.lock,
                  prefixIconColor: Colors.blue,
                  obscuringCharacter: '.',
                  fontSize: 15.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Forget password',
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    buttonName: 'Login',
                    buttonColor: Colors.white,
                    fontColor: Colors.purple,
                    onPressed: () {
                      authBloc.add(AuthUserLoginEvent(
                          email: emailController.text,
                          password: passwordController.text));
                    }),
                MyButton(
                    buttonName: 'Sign in with Google',
                    buttonColor: Colors.red,
                    fontColor: Colors.white,
                    onPressed: () {
                      // context.read<AuthBloc>().add(AuthUserGoogleCheckEvent());
                      authBloc.add(AuthUserGoogleLoginEvent());
                    }),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Don\'t have an account?  ',
                          style: const TextStyle(
                              // decoration: TextDecoration.underline,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Create',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/signup');
                                  })
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
