import 'package:bloc_sample/features/counter/cubit/counter_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCounterPage extends StatefulWidget {
  const NewCounterPage({super.key});

  @override
  State<NewCounterPage> createState() => _NewCounterPageState();
}

class _NewCounterPageState extends State<NewCounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit counter Page'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubitCubit, CounterCubitState>(
            builder: (ctx, state) {
          if (state is CounterCubitIncrementstate) {
            return Text('${state.value}');
          }
          return const Text('0');
        }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            context.read<CounterCubitCubit>().increment();
          }),
    );
  }
}
