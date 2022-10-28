// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'order.freezed.dart';
// part 'order.g.dart';

// @freezed
// abstract class Order with _$Order {
//   const factory Order({
//     @JsonKey(name: 'id') String? id,
//     @JsonKey(name: 'customerId') String? customerId,
//     @JsonKey(name: 'sellerId') String? sellerId,
//     @JsonKey(name: 'createdAt') String? createdAt,
//     @JsonKey(name: 'items') List<Map<String, dynamic>>? items,
//     @JsonKey(name: 'itemsCategory') String? itemsCategory,
//     @JsonKey(name: 'totalPayment') int? totalPayment,
//     @JsonKey(name: 'methodPayment') String? methodPayment,
//     @JsonKey(name: 'statusPayment') String? statusPayment,
//     @JsonKey(name: 'tokenPayment') String? tokenPayment,
//   }) = _Order;

//   factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
// }

// create class model order
class Order {
  String? id;
  String? orderId;
  String? customerId;
  String? sellerId;
  String? createdAt;
  List<dynamic>? items;
  String? itemsCategory;
  int? totalPayment;
  String? methodPayment;
  String? statusPayment;
  String? tokenPayment;

  Order({
    this.id,
    this.orderId,
    this.customerId,
    this.sellerId,
    this.createdAt,
    this.items,
    this.itemsCategory,
    this.totalPayment,
    this.methodPayment,
    this.statusPayment,
    this.tokenPayment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['orderId'],
      customerId: json['customerId'],
      sellerId: json['sellerId'],
      createdAt: json['createdAt'],
      items: json['items'],
      itemsCategory: json['itemsCategory'],
      totalPayment: json['totalPayment'],
      methodPayment: json['methodPayment'],
      statusPayment: json['statusPayment'],
      tokenPayment: json['tokenPayment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'customerId': customerId,
      'sellerId': sellerId,
      'createdAt': createdAt,
      'items': items,
      'itemsCategory': itemsCategory,
      'totalPayment': totalPayment,
      'methodPayment': methodPayment,
      'statusPayment': statusPayment,
      'tokenPayment': tokenPayment,
    };
  }

  Order copyWith({
    String? id,
    String? orderId,
    String? customerId,
    String? sellerId,
    String? createdAt,
    List<Map<String, dynamic>>? items,
    String? itemsCategory,
    int? totalPayment,
    String? methodPayment,
    String? statusPayment,
    String? tokenPayment,
  }) {
    return Order(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      customerId: customerId ?? this.customerId,
      sellerId: sellerId ?? this.sellerId,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      itemsCategory: itemsCategory ?? this.itemsCategory,
      totalPayment: totalPayment ?? this.totalPayment,
      methodPayment: methodPayment ?? this.methodPayment,
      statusPayment: statusPayment ?? this.statusPayment,
      tokenPayment: tokenPayment ?? this.tokenPayment,
    );
  }
}
