import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stripe_shopper/state/application_login_state.dart';
import 'package:test_stripe_shopper/utils/firestore.dart';

import '../components/custom_button.dart';
import '../models/product.dart';
import '../utils/custom_theme.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool addButtonLoad = false;

  ///
  Future<void> onAddToCart() async {
    setState(() => addButtonLoad = true);

    await FirestoreUtil.addToCart(context.read<ApplicationState>().user, widget.product.id);

    setState(() => addButtonLoad = false);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: CachedNetworkImage(imageUrl: widget.product.image, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 35,
                        right: 35,
                        child: DecoratedBox(
                          decoration: const ShapeDecoration(
                            color: CustomTheme.yellow,
                            shape: CircleBorder(),
                            shadows: CustomTheme.buttonShadow,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.headlineLarge!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 22), child: Text(widget.product.title)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                const Text('MRP: '),
                                Text(widget.product.price.toString()),
                              ],
                            ),
                          ),
                          CustomButton(text: 'add to cart', press: onAddToCart, loading: addButtonLoad),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              widget.product.category,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              widget.product.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: CustomTheme.cardShadow,
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
