import 'package:ecommerce_dearch_firebase/features/product/models/product_model.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {super.key, required this.productDataModel, required this.homeBloc});

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(productDataModel.image),
          ),
          Text(productDataModel.category.name,
              style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
