import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_health.freezed.dart';
part 'history_health.g.dart';

@freezed
abstract class HistoryHealth with _$HistoryHealth {
  const factory HistoryHealth({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'petId') String? petId,
    @JsonKey(name: 'time') String? time,
    @JsonKey(name: 'problem') List<String>? problem,
    @JsonKey(name: 'desc') String? desc,
  }) = _HistoryHealth;

  factory HistoryHealth.fromJson(Map<String, dynamic> json) => _$HistoryHealthFromJson(json);
}
