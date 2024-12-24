import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/data/cart_items.dart';
import 'package:bloc_sample/data/grocery_data.dart';
import 'package:bloc_sample/data/wishlist_items.dart';
import 'package:bloc_sample/features/home/models/home_product_data.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<ProductDataModel> _products = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickEvent>(
        homeProductWishlistButtonClickEvent);
    on<HomeProductCartButtonClickEvent>(homeProductCartButtonClickEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(Duration(seconds: 3));

    _products
        .addAll(GroceryData.groceryProducts.map((toElement) => ProductDataModel(
              id: toElement['id'],
              name: toElement['name'],
              description: toElement['description'],
              price: toElement['price'],
              imageUrl: toElement['imageUrl'],
              count: 0,
            )));
    emit(HomeLoadedSuccessState(products: _products));
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Home wishlist navigate page clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart navigate page is clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickEvent(
      HomeProductWishlistButtonClickEvent event, Emitter<HomeState> emit) {
    final existingWishlistItemsIndex = wishlistItems
        .indexWhere((product) => product.id == event.clickedProduct.id);
    if (existingWishlistItemsIndex == -1) {
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishlistMoreThanOneClickedstate());
    }
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickEvent(
      HomeProductCartButtonClickEvent event, Emitter<HomeState> emit) {
    /// find the index of the clicked product from cartItemslist
    final existingCartItemIndex = cartItems
        .indexWhere((product) => product.id == event.clickedProduct.id);

    /// if the product is already in the cart, count alone is increased to 1
    /// if not then add the product to cartItems with count value 1 -> as it is pressed once
    /// -1 indicates item is not in cart
    if (existingCartItemIndex != -1) {
      cartItems[existingCartItemIndex].count += 1;
    } else {
      final updatedProduct = ProductDataModel(
        id: event.clickedProduct.id,
        name: event.clickedProduct.name,
        description: event.clickedProduct.description,
        price: event.clickedProduct.price,
        imageUrl: event.clickedProduct.imageUrl,
        count: 1, // Start count at 1 when adding to the cart
      );
      cartItems.add(updatedProduct);
    }

    // final productIndex = _products.indexWhere((product) => product.id == event.clickedProduct.id);
    // if (productIndex != -1) {
    //   //firstWhere returns the first element that matches the condition
    //   _products[productIndex].count = cartItems.firstWhere((cartItem) => cartItem.id == _products[productIndex].id).count;
    // }

    emit(HomeLoadedSuccessState(
        products: List<ProductDataModel>.from(_products)));

    emit(HomeProductItemCartlistedActionState());
  }
}
