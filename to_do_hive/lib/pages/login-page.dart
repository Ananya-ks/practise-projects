import 'package:flutter/material.dart';
import 'package:to_do_hive/pages/to-do-main-page.dart';
import '../pages/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  
  /// TextEditingController -> creates a controller for editable text field. Also gives access to the text, the user types
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// SingleChildScrollableView -> make a widget scroll when its content overflows out of the page.
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/login.webp',
            width: 500.0,
            height: 400.0,
          ),
          MyTextField(
            controller: userNameController,
            prefixIconData: Icons.person,
            prefixIconColor: Colors.blue,
            hintText: 'Username',
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
          const MyButton(),
          const SizedBox(
            height: 15.0,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
              Text(
                'Create',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      //this doesn't wrk
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ToDoMainPage()));
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
