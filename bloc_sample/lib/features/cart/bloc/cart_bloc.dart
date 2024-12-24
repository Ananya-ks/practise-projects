import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/data/cart_items.dart';
import 'package:bloc_sample/features/home/models/home_product_data.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
    CartRemoveFromCartEvent event, Emitter<CartState> emit) {
  final productIndex = cartItems.indexWhere((product) => product.id == event.productDataModel.id);

  if (productIndex != -1) { // If the product is found in cartItems
    // Decrease the count of the selected product
    if (cartItems[productIndex].count > 1) {
      cartItems[productIndex].count -= 1;  // Decrease count by 1
    } else {
      // If the count is 1 or less, remove the product from the cart
      cartItems.removeAt(productIndex);
    }

    // Emit the updated cart state with the new cartItems
    emit(CartSuccessState(cartItems: List<ProductDataModel>.from(cartItems)));
  }
}

}
