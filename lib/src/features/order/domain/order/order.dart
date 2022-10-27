import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
abstract class Order with _$Order {
  const factory Order({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'customerId') String? customerId,
    @JsonKey(name: 'sellerId') String? sellerId,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'items') List<Map<String, dynamic>>? items,
    @JsonKey(name: 'itemsCategory') String? itemsCategory,
    @JsonKey(name: 'totalPayment') int? totalPayment,
    @JsonKey(name: 'methodPayment') String? methodPayment,
    @JsonKey(name: 'statusPayment') String? statusPayment,
    @JsonKey(name: 'tokenPayment') String? tokenPayment,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
