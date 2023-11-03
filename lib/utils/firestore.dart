import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart.dart';
import '../models/product.dart';

// ignore: avoid_classes_with_only_static_members
class FirestoreUtil {
  static const String productCollection = 'product';
  static const String customerCollection = 'customer';
  static const String cartCollection = 'cart';

  ///
  static Future<List<Product>> getProducts(List<String>? ids) async {
    try {
      final productRef = FirebaseFirestore.instance.collection(productCollection).withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson(),
          );

      QuerySnapshot<Product> productDoc;
      if (ids != null && ids.isNotEmpty) {
        productDoc = await productRef.where('id', whereIn: ids).get();
      } else {
        productDoc = await productRef.get();
      }

      return productDoc.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e, stackTrace) {
      log('error!!', stackTrace: stackTrace, error: e);
    }

    return [];
  }

  ///
  static Future<dynamic> addToCart(User? user, String productId) async {
    if (user == null) {
      return;
    }

    try {
      final product = FirebaseFirestore.instance
          .collection(customerCollection)
          .doc(user.uid)
          .collection(cartCollection)
          .doc(productId);

      if ((await product.get()).exists) {
        await product.update({'id': productId, 'count': FieldValue.increment(1)});
      } else {
        await product.set({'id': productId, 'count': 1});
      }
    } on FirebaseException catch (e, stackTrace) {
      log('error!!', stackTrace: stackTrace, error: e);
    }
  }

  ///
  static Future<List<Cart>> getCart(User? user) async {
    final carts = <Cart>[];

    try {
      final cartRef = await FirebaseFirestore.instance
          .collection(customerCollection)
          .doc(user?.uid)
          .collection(cartCollection)
          .get();

      final productIds = <String>[];

      for (final element in cartRef.docs) {
        productIds.add(element['id']);
      }

      final products = await getProducts(productIds);

      for (final element in cartRef.docs) {
        final product = products.firstWhere((prod) => prod.id == element.id);
        final json = product.toJson();
        json['count'] = element['count'];
        carts.add(Cart.fromJson(json));
      }
    } on FirebaseException catch (e, stackTrace) {
      log('error!!', stackTrace: stackTrace, error: e);
    }

    return carts;
  }

  ///
  static double getCartTotal(List<Cart> carts) {
    var total = 0.0;
    for (final cart in carts) {
      total += cart.price * cart.count.toDouble();
    }
    return total;
  }
}
