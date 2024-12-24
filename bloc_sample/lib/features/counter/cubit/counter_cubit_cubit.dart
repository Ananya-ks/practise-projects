import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_cubit_state.dart';

class CounterCubitCubit extends Cubit<CounterCubitState> {
  CounterCubitCubit() : super(CounterCubitInitial());

  void increment() {
    if (state is CounterCubitIncrementstate) {
      final currentValue = (state as CounterCubitIncrementstate).value;
      emit(CounterCubitIncrementstate(value: currentValue + 1));
    } else {
      emit(CounterCubitIncrementstate(value: 1));
    }
  }

  void decrement() {
    final currentValue = (state as CounterCubitIncrementstate).value;
    emit(CounterCubitIncrementstate(value: currentValue - 1));
  }
}
