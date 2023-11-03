import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product(this.title, this.price, this.id, this.description, this.image, this.category);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  String title;
  double price;
  String id;
  String description;
  String image;

  @JsonKey(defaultValue: '')
  String category;

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
