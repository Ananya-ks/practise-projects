import 'package:flutter/material.dart';

class MyNewButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyNewButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white),),
    );
  }
}
