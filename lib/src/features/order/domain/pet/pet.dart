class Pet {
  String? id;
  String? image;
  String? usersId;
  String? name;
  String? category;
  String? breed;
  String? sex;
  int? weight;
  String? condition;
  List<dynamic>? health;

  Pet({
    this.id,
    this.image,
    this.usersId,
    this.name,
    this.category,
    this.breed,
    this.sex,
    this.weight,
    this.condition,
    this.health,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      image: json['image'],
      usersId: json['usersId'],
      name: json['name'],
      category: json['category'],
      breed: json['breed'],
      sex: json['sex'],
      weight: json['weight'],
      condition: json['condition'],
      health: json['health'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'usersId': usersId,
      'name': name,
      'category': category,
      'breed': breed,
      'sex': sex,
      'weight': weight,
      'condition': condition,
      'health': health,
    };
  }

  Pet copyWith({
    String? id,
    String? image,
    String? usersId,
    String? name,
    String? category,
    String? breed,
    String? sex,
    int? weight,
    String? condition,
    List<Map<String, dynamic>>? health,
  }) {
    return Pet(
      id: id ?? this.id,
      image: image ?? this.image,
      usersId: usersId ?? this.usersId,
      name: name ?? this.name,
      category: category ?? this.category,
      breed: breed ?? this.breed,
      sex: sex ?? this.sex,
      weight: weight ?? this.weight,
      condition: condition ?? this.condition,
      health: health ?? this.health,
    );
  }
}
