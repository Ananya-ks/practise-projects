import 'package:ecommerce_dearch_firebase/features/product/models/product_model.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/home/home_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/category_tile.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_search_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // if used fetchApi() in init, whenever
  // @override
  // void initState() {
  //   homeBloc.add(HomePageInitialEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //below 2 lines are same meaning
    //USED FOR ACCESSING THE BLOCS. RETRIEVES HOMEBLOC INSTANCE FROM WIDGET TREE PROVIDED EARLIER BY MULTIPROVIDER

    // final homeBloc = BlocProvider.of<HomeBloc>(context);
    final homeBloc = context.watch<HomeBloc>();

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeLoadingState) {}
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            final Map<String, ProductDataModel> categoryUniqueValues = {};
            for (var product in successState.products) {
              if (!categoryUniqueValues.containsKey(product.category.name)) {
                //EX: categoryUniqueValues[electronics] = ProductDataModel(id:..,titile;..)
                categoryUniqueValues[product.category.name] = product;
              }
            }
            final uniqueCategoryProducts = categoryUniqueValues.values.toList();
            return Column(
              children: [
                Container(
                  height: 120.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueCategoryProducts.length,
                      physics:
                          const BouncingScrollPhysics(), // Smooth scroll behavior
                      itemBuilder: (ctx, index) {
                        return Container(
                          child: CategoryTile(
                              productDataModel: uniqueCategoryProducts[index],
                              homeBloc: homeBloc),
                        );
                      }),
                ),
                const SizedBox(
                  width: 350.0,
                  child: CustomSearchTextfield(
                    hintText: 'Search here',
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: successState.filteredProducts.length,
                      itemBuilder: (ctx, index) {
                        return ProductTile(
                            productDataModel:
                                successState.filteredProducts[index],
                            homeBloc: homeBloc);
                      }),
                ),
              ],
            );
          case HomeLoadedErrorState:
            final errorState = state as HomeLoadedErrorState;
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline),
                  Text(errorState.message)
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
