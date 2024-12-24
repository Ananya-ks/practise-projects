import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchTextfield extends StatelessWidget {
  const CustomSearchTextfield({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        context.read<HomeBloc>().add(HomeSearchEvent(query: query));
      },
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13.0),
          fillColor: Colors.grey[300]?.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          )),
    );
  }
}
