// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      category: json['category'] as String?,
      seller: json['seller'] as String?,
      location: json['location'] as String?,
      desc: json['desc'] as String?,
      stock: json['stock'] as int?,
      price: json['price'] as int?,
      sold: json['sold'] as int?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'image': instance.image,
      'category': instance.category,
      'seller': instance.seller,
      'location': instance.location,
      'desc': instance.desc,
      'stock': instance.stock,
      'price': instance.price,
      'sold': instance.sold,
    };
