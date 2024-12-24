import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/email_verification.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/login.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/custom_button.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/custom_text_field.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/wrapper_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  /// TextEditingController -> creates a controller for editable text field. Also gives access to the text, the user types
  final userNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    /// SingleChildScrollableView -> make a widget scroll when its content overflows out of the page.
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is AuthUserCreationSuccessActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => LoginPage()));
        } else if (state is AuthUserCreationFailureActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthUserEmailVerificationLoadingState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => EmailVerificationScreen()));
        } else if (state is AuthUserEmailVerificationSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => WrapperAuth()));
        }
      },
      builder: (context, state) {
        if (state is AuthUserCreationLoadingState) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('E-Commerce'),
              centerTitle: true,
            ),
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
                    controller: userNameController,
                    prefixIconData: Icons.person,
                    prefixIconColor: Colors.blue,
                    hintText: 'Name',
                    obsecureText: false,
                    obscuringCharacter: '/',
                    fontSize: 15.0,
                  ),
                  const SizedBox(
                    height: 10.0,
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
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    buttonColor: Colors.white,
                    fontColor: Colors.purple,
                    onPressed: () {
                      authBloc.add(AuthUserCreationEvent(
                          email: emailController.text,
                          password: passwordController.text));
                      authBloc.add(AuthUserEmailVerificationEvent());
                    },
                    buttonName: 'Signup',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
