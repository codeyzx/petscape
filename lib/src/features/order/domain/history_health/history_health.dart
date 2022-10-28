// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'history_health.freezed.dart';
// part 'history_health.g.dart';

// @freezed
// abstract class HistoryHealth with _$HistoryHealth {
//   const factory HistoryHealth({
//     @JsonKey(name: 'id') String? id,
//     @JsonKey(name: 'petId') String? petId,
//     @JsonKey(name: 'time') String? time,
//     @JsonKey(name: 'problem') List<String>? problem,
//     @JsonKey(name: 'vets') List<String>? vets,
//     @JsonKey(name: 'desc') String? desc,
//   }) = _HistoryHealth;

//   factory HistoryHealth.fromJson(Map<String, dynamic> json) => _$HistoryHealthFromJson(json);
// }

// create class model historyhealth
class HistoryHealth {
  String? id;
  String? petId;
  String? time;
  List<String>? problem;
  Map<String, dynamic>? vets;
  String? desc;

  HistoryHealth({
    this.id,
    this.petId,
    this.time,
    this.problem,
    this.vets,
    this.desc,
  });

  factory HistoryHealth.fromJson(Map<String, dynamic> json) {
    return HistoryHealth(
      id: json['id'],
      petId: json['petId'],
      time: json['time'],
      problem: json['problem'],
      vets: json['vets'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'time': time,
      'problem': problem,
      'vets': vets,
      'desc': desc,
    };
  }

  HistoryHealth copyWith({
    String? id,
    String? petId,
    String? time,
    List<String>? problem,
    Map<String, dynamic>? vets,
    String? desc,
  }) {
    return HistoryHealth(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      time: time ?? this.time,
      problem: problem ?? this.problem,
      vets: vets ?? this.vets,
      desc: desc ?? this.desc,
    );
  }
}
