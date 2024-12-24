import 'package:ecommerce_dearch_firebase/features/product/models/product_model.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  productDataModel.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10), // Spacing between image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      productDataModel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      // maxLines: 1, // Optional: Limit title to one line
                      // overflow: TextOverflow.ellipsis, // Optional: Add ellipsis for overflow
                    ),
                    const SizedBox(height: 5), // Spacing between title and description
                    Text(
                      productDataModel.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      // maxLines: 2, // Optional: Limit description to two lines
                      // overflow: TextOverflow.ellipsis, // Optional: Add ellipsis for overflow
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
