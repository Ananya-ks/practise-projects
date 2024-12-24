part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

/// as soon as home page loads this initial state happens
final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

/// when loading of home page is success, list of products of type ProductDataModel must be displayed
class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeLoadedErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemWishlistMoreThanOneClickedstate extends HomeActionState {}

class HomeProductItemCartlistedActionState extends HomeActionState {}

class HomeProductItemClickedMoreThan1Actionstate extends HomeActionState {}
