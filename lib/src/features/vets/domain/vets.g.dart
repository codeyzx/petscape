// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Vets _$$_VetsFromJson(Map<String, dynamic> json) => _$_Vets(
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      degree: json['degree'] as String?,
      address: json['address'] as String?,
      patient: json['patient'] as int?,
      experience: json['experience'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
      category: json['category'] as String?,
      workTime: json['workTime'] as String?,
      location: json['location'] as String?,
      price: json['price'] as int?,
      desc: json['desc'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      doctorId: json['doctorId'] as String?,
    );

Map<String, dynamic> _$$_VetsToJson(_$_Vets instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'degree': instance.degree,
      'address': instance.address,
      'patient': instance.patient,
      'experience': instance.experience,
      'rate': instance.rate,
      'category': instance.category,
      'workTime': instance.workTime,
      'location': instance.location,
      'price': instance.price,
      'desc': instance.desc,
      'email': instance.email,
      'phone': instance.phone,
      'doctorId': instance.doctorId,
    };
