import 'package:bloc_sample/features/counter/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterBloc counterBloc = CounterBloc();
  int val = 0;

  @override
  void initState() {
    counterBloc.add(CounterIncrementEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter Page")),
      body: BlocConsumer<CounterBloc, CounterState>(
        bloc: counterBloc,

        /// listenwhen happens only when the current state is an ActionState only so we defined a abstract class and extending it for every actionState
        listenWhen: (prev, curr) => curr is CounterActionState,
        //// buildWhen happens only current state is not an actionState
        buildWhen: (prev, curr) => curr is! CounterActionState,
        listener: (context, state) {
          if (state is CounterActionShowSnackbarState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('It is a BLoC snackbar')));
          } else if (state is CounterIncrementActionState) {
            setState(() {
              val = val + 1;
            });
          }
        },
        builder: (context, state) {
          /// state.runtimeType - returns the type of current state either counterInitial or counterIncrementState
          switch (state.runtimeType) {
            ///state -> a variable refering to current state emitted by BLoC. All state extend from common class CounterState
            case CounterIncrementState:

              /// as all state are extended, CounterInitial, CounterIncrementState. It is type casted as use the 'state as CounterIncrementState'
              final successState = state as CounterIncrementState;
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        successState.value.toString(),
                        style: const TextStyle(fontSize: 40),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            counterBloc.add(CounterActionShowSnackbarEvent());
                          },
                          child: Text('Snackbar')),
                    ],
                  ),
                ),
              );
            default:
              return const Center(
                child: Text('Not found'),
              );
          }
        },
      ),

      /// below is for bloclistener
      // body: BlocListener<CounterBloc, CounterState>(
      //   bloc: counterBloc,
      //   listener: (context, state) {
      //     if (state is CounterActionShowSnackbarState) {
      //       ScaffoldMessenger.of(context)
      //           .showSnackBar(SnackBar(content: Text('It is a BLoC snackbar')));
      //     } else if (state is CounterIncrementActionState) {
      //       setState(() {
      //         val = val + 1;
      //       });
      //     }
      //   },
      //   child: Center(
      //     child: Container(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(
      //             val.toString(),
      //             style: TextStyle(fontSize: 40),
      //           ),
      //           ElevatedButton(
      //               onPressed: () {
      //                 counterBloc.add(CounterIncrementEvent());
      //               },
      //               child: Text('Add')),
      //           ElevatedButton(
      //               onPressed: () {
      //                 counterBloc.add(CounterActionShowSnackbarEvent());
      //               },
      //               child: Text('Snackbar')),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      /// BlocBuilder - widget that listens to counterBloc and rebuilds UI when state changes
      // body: BlocBuilder<CounterBloc, CounterState>(
      //   bloc: counterBloc,
      // builder: (context, state) {
      //   /// state.runtimeType - returns the type of current state either counterInitial or counterIncrementState
      //   switch (state.runtimeType) {
      //     ///state -> a variable refering to current state emitted by BLoC. All state extend from common class CounterState
      //     case CounterIncrementState:
      //     /// as all state are extended, CounterInitial, CounterIncrementState. It is type casted as use the 'state as CounterIncrementState'
      //       final successState = state as CounterIncrementState;
      //       return Center(
      //         child: Container(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 successState.value.toString(),
      //                 style: const TextStyle(fontSize: 40),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     default:
      //       return const Center(
      //         child: Text('Not found'),
      //       );
      //   }
      // },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterBloc.add(CounterIncrementEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
