import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './pages/pages.dart';

// sample to-do branch
//additional comment
void main()async{
  /// initiate hive flutter
  await Hive.initFlutter();
  /// create a box to store the datas
  /// here 'todobox' is a key to access the box allover the application.
  var box = await Hive.openBox('todobox');
  print(box);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingPage(),
    );
  }
}
