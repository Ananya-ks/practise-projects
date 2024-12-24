// import 'package:bloc_sample/features/counter/ui/counter_page.dart';
import 'package:bloc_sample/features/counter/cubit/counter_cubit_cubit.dart';
// import 'package:bloc_sample/features/counter/ui/counter_page.dart';
import 'package:bloc_sample/features/counter/ui/new_counter_page.dart';
// import 'package:bloc_sample/features/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   // home: HomePage(),
    //   home: CounterPage(),
    // );
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubitCubit(),
        child: NewCounterPage(),
      ),
    );
  }
}
