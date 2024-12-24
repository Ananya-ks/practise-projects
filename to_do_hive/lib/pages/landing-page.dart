import 'package:flutter/material.dart';
import '../pages/pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Image.asset('assets/landing.jpg'),
          const Padding(
            padding: EdgeInsets.all(50.0),
            child: Text(
              'You can manage everything here..!!!!',
              softWrap: true,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'IndieFlower',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Colors.deepPurple.shade400),
                  foregroundColor:
                      const WidgetStatePropertyAll<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const HomePage()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 21.0,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
