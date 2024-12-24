part of 'counter_bloc.dart';

@immutable

/// CounterState - a base class for managing all possible states
/// sealed - ensures subclasses defined in the same file can extend CounterState
sealed class CounterState {}

final class CounterInitial extends CounterState {}

class CounterIncrementState extends CounterState {
  final int value;

  CounterIncrementState({required this.value});
}

/// specifically just for actions not for rebuilding
abstract class CounterActionState extends CounterState {}

class CounterActionShowSnackbarState extends CounterActionState {}

class CounterIncrementActionState extends CounterActionState {}
