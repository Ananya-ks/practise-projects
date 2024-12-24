part of 'counter_bloc.dart';

/// @immutable - when instance of the class is created, its properties cannot be changed
@immutable

/// CounterEvent - a base class for different kind of events
sealed class CounterEvent {}

class CounterActionShowSnackbarEvent extends CounterEvent {}

/// Event saying user wants to increase the counter
/// When user clicks a button 'CounterIncrementEvent' is sent to the BLoC
class CounterIncrementEvent extends CounterEvent {}
