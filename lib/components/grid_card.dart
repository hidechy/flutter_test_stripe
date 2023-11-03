import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/custom_theme.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.index, required this.press, required this.product});

  final int index;
  final void Function() press;
  final Product product;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index.isEven ? const EdgeInsets.only(left: 15) : const EdgeInsets.only(right: 15),
      decoration: CustomTheme.getCardDecoration(),
      child: GestureDetector(
        onTap: press,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(imageUrl: product.image, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        product.price.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
