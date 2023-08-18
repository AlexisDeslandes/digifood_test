import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

/// Represent the model of a product.
@freezed
class Product with _$Product {
  /// default constructor
  const factory Product({
    required String name,
    required double price,
    required String category,
    String? description,
  }) = _Product;

  /// Constructor from JSON object.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
