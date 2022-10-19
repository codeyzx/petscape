import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
abstract class Products with _$Products {
  const factory Products({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'desc') String? desc,
    @JsonKey(name: 'category') String? category,
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);
}
