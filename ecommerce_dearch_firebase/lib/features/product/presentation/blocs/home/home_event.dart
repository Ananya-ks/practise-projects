part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomePageInitialEvent extends HomeEvent {}

class HomeSearchEvent extends HomeEvent {
  final String query;
  HomeSearchEvent({required this.query});
}
