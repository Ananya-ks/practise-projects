part of 'counter_cubit_cubit.dart';

@immutable
sealed class CounterCubitState {}

final class CounterCubitInitial extends CounterCubitState {}

class CounterCubitIncrementstate extends CounterCubitState {
  final int value;
  CounterCubitIncrementstate({required this.value});
}
