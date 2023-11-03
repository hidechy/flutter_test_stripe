import 'package:flutter/material.dart';

import '../components/grid_card.dart';
import '../components/loader.dart';
import '../models/product.dart';
import '../utils/firestore.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///
  late Future<List<Product>> products;

  ///
  @override
  void initState() {
    super.initState();

    products = FirestoreUtil.getProducts([]);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
            ),
            itemBuilder: (context, index) {
              return GridCard(
                index: index,
                press: () => onCardPress(snapshot.data![index]),
                product: snapshot.data![index],
              );
            },
            itemCount: snapshot.data?.length,
          );
        } else {
          return const Center(child: Loader());
        }
      },
    );
  }

  ///
  void onCardPress(Product product) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: product)));
  }
}
