import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'seller') String? seller,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'desc') String? desc,
    @JsonKey(name: 'stock') int? stock,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'sold') int? sold,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
