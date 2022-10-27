import 'package:freezed_annotation/freezed_annotation.dart';

part 'vets.freezed.dart';
part 'vets.g.dart';

@freezed
abstract class Vets with _$Vets {
  const factory Vets({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'degree') String? degree,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'patient') int? patient,
    @JsonKey(name: 'experience') int? experience,
    @JsonKey(name: 'rate') double? rate,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'workTime') String? workTime,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'desc') String? desc,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'doctorId') String? doctorId,
  }) = _Vets;

  factory Vets.fromJson(Map<String, dynamic> json) => _$VetsFromJson(json);
}
