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
