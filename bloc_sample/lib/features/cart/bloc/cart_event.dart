part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

//cart-event
class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartRemoveFromCartEvent({required this.productDataModel});
}
