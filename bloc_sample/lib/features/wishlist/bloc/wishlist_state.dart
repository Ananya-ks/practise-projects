part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

abstract class WishlistActionState {}

class WishListSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;

  WishListSuccessState({required this.wishlistItems});
}

class WishlistErrorState extends WishlistState {}
