import 'package:bloc_sample/features/home/models/home_product_data.dart';
import 'package:bloc_sample/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';

class WishlistTile extends StatelessWidget {
  const WishlistTile(
      {super.key, required this.productDataModel, required this.wishlistBloc});

  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(productDataModel.imageUrl))),
              ),
              Text(productDataModel.name),
              Text(productDataModel.description),
              Text(' \$ ${productDataModel.price.toString()}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        wishlistBloc.add(WishlistRemoveEvent(
                            productDataModel: productDataModel));
                      },
                      
                      icon: const Icon(Icons.favorite_sharp)),
                  IconButton(
                      onPressed: () {
                        // wishlistBloc.add(CartRemoveFromCartEvent(
                        //     productDataModel: productDataModel));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
