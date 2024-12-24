import 'package:bloc_sample/features/home/bloc/home_bloc.dart';
import 'package:bloc_sample/features/home/models/home_product_data.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  ProductTile(
      {super.key, required this.productDataModel, required this.homeBloc});

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

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
              // Text('${productDataModel.count}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickEvent(
                            clickedProduct: productDataModel));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickEvent(
                            clickedProduct: productDataModel));
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
