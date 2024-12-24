import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/// CounterBloc - listens to the event and emits the state

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    /// registers a listener for CounterIncrementEvent
    /// when a user presses a button, counterIncrementEvent will be triggered.
    on<CounterIncrementEvent>(counterIncrementEvent);
    on<CounterActionShowSnackbarEvent>(counterActionShowSnackbar);
  }

  int value = 0;

  /// function returns either Future (for async operations like API calls) or void (for synchronous operation like here)
  FutureOr<void> counterIncrementEvent(
      CounterIncrementEvent event, Emitter<CounterState> emit) {
    value = value + 1;

    /// emit always emits a state, used for BLoC builder
    emit(CounterIncrementState(value: value));

    /// used in BloC listener
    // emit(CounterIncrementActionState());
  }

  FutureOr<void> counterActionShowSnackbar(
      CounterActionShowSnackbarEvent event, Emitter<CounterState> emit) {
    emit(CounterActionShowSnackbarState());
  }
}
