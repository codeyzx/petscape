import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petscape/src/features/order/domain/history_health/history_health.dart';

part 'pet.freezed.dart';
part 'pet.g.dart';

@freezed
abstract class Pet with _$Pet {
  const factory Pet({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'usersId') String? usersId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'breed') String? breed,
    @JsonKey(name: 'sex') String? sex,
    @JsonKey(name: 'weight') int? weight,
    @JsonKey(name: 'condition') String? condition,
    @JsonKey(name: 'health') List<Map<String, dynamic>>? health,
  }) = _Pet;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
}
