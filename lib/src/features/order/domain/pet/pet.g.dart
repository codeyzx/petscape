// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pet _$$_PetFromJson(Map<String, dynamic> json) => _$_Pet(
      id: json['id'] as String?,
      image: json['image'] as String?,
      usersId: json['usersId'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      breed: json['breed'] as String?,
      sex: json['sex'] as String?,
      weight: json['weight'] as int?,
      condition: json['condition'] as String?,
      health: (json['health'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_PetToJson(_$_Pet instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'usersId': instance.usersId,
      'name': instance.name,
      'category': instance.category,
      'breed': instance.breed,
      'sex': instance.sex,
      'weight': instance.weight,
      'condition': instance.condition,
      'health': instance.health,
    };
