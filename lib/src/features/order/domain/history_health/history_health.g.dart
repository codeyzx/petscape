// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HistoryHealth _$$_HistoryHealthFromJson(Map<String, dynamic> json) =>
    _$_HistoryHealth(
      id: json['id'] as String?,
      petId: json['petId'] as String?,
      time: json['time'] as String?,
      problem:
          (json['problem'] as List<dynamic>?)?.map((e) => e as String).toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$$_HistoryHealthToJson(_$_HistoryHealth instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'time': instance.time,
      'problem': instance.problem,
      'desc': instance.desc,
    };
