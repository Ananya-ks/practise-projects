part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  final List<ProductDataModel> filteredProducts;

  HomeLoadedSuccessState(
      {required this.products, required this.filteredProducts});
}

class HomeLoadedErrorState extends HomeState {
  final String message;
  HomeLoadedErrorState({required this.message});
}
