// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      sellerId: json['sellerId'] as String?,
      createdAt: json['createdAt'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      itemsCategory: json['itemsCategory'] as String?,
      totalPayment: json['totalPayment'] as int?,
      methodPayment: json['methodPayment'] as String?,
      statusPayment: json['statusPayment'] as String?,
      tokenPayment: json['tokenPayment'] as String?,
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'sellerId': instance.sellerId,
      'createdAt': instance.createdAt,
      'items': instance.items,
      'itemsCategory': instance.itemsCategory,
      'totalPayment': instance.totalPayment,
      'methodPayment': instance.methodPayment,
      'statusPayment': instance.statusPayment,
      'tokenPayment': instance.tokenPayment,
    };
