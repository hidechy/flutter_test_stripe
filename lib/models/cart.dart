import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Product {
  Cart(
    super.title,
    super.price,
    super.id,
    super.description,
    super.image,
    super.category,
    this.count,
  );

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  int count = 0;
}
