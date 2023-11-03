import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_stripe_shopper/state/application_login_state.dart';
import 'package:test_stripe_shopper/utils/custom_theme.dart';
import 'package:test_stripe_shopper/utils/firestore.dart';

import '../components/custom_button.dart';
import '../components/list_card.dart';
import '../components/loader.dart';
import '../models/cart.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  ///
  Future<List<Cart>>? carts;
  bool _checkoutButtonLoading = false;

  ///
  @override
  void initState() {
    super.initState();

    carts = FirestoreUtil.getCart(context.read<ApplicationState>().user);
  }

  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: carts,
      builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListCard(cart: snapshot.data![index]);
                  },
                ),
                priceFooter(snapshot.data!),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: CustomButton(
                    text: 'Checkout',
                    press: () {},
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.data != null && snapshot.data!.isEmpty) {
          return const Center(
            child: Icon(Icons.add_shopping_cart_sharp, color: CustomTheme.yellow, size: 150),
          );
        } else {
          return const Center(child: Loader());
        }
      },
    );
  }

  ///
  Widget priceFooter(List<Cart> cartsList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 2, color: Colors.grey, thickness: 2),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  'total: ',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Text(
                  FirestoreUtil.getCartTotal(cartsList).toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
