import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// example for Cubit and MultiBlocProvider


// CounterCubit to manage the count state
@immutable
class CounterState {
  final int count;
  CounterState({required this.count});
}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(count: 0));

  void increment() => emit(CounterState(count: state.count + 1));
  void decrement() => emit(CounterState(count: state.count - 1));
}

// AuthCubit to manage authentication state
@immutable
class AuthState {
  final bool isAuthenticated;
  AuthState({required this.isAuthenticated});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(isAuthenticated: false));

  void login() => emit(AuthState(isAuthenticated: true));
  void logout() => emit(AuthState(isAuthenticated: false));
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MultiProvider Example',
      home: MultiBlocProvider(
        providers: [
          // Providing the CounterCubit
          BlocProvider(create: (context) => CounterCubit()),

          // Providing the AuthCubit
          BlocProvider(create: (context) => AuthCubit()),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MultiProvider Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display Authentication Status
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return Text(
                authState.isAuthenticated ? 'Logged In' : 'Logged Out',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),

          // Counter Display and Controls
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, counterState) {
              return Text(
                'Counter: ${counterState.count}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<CounterCubit>().increment();
                },
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Login/Logout Controls
          ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().login();
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
