class Order {
  String? id;
  String? orderId;
  String? customerId;
  String? sellerId;
  String? address;
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
    this.address,
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
      address: json['address'],
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
      'address': address,
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
    String? address,
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
      address: address ?? this.address,
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
