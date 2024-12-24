import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/models/product_model.dart';
import 'package:ecommerce_dearch_firebase/features/product/services/api_services.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<ProductDataModel> _products = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomePageInitialEvent>(homePageInitialEvent);
    on<HomeSearchEvent>(homeSearchEvent);
  }

  FutureOr<void> homePageInitialEvent(
      HomePageInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final fetchedProducts = await ProductApi.fetchProduct();
      _products.addAll(fetchedProducts);
      emit(HomeLoadedSuccessState(products: _products, filteredProducts: _products));
    } catch (e) {
      emit(HomeLoadedErrorState(message: e.toString()));
    }
  }

  FutureOr<void> homeSearchEvent(
      HomeSearchEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadedSuccessState) {
      final currentState = state as HomeLoadedSuccessState;
      final filteredProducts = currentState.products.where((product) =>product.title.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(HomeLoadedSuccessState(products: currentState.products, filteredProducts: filteredProducts));
    }
  }
}
