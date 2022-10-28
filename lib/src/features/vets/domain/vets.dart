class Vets {
  String? id;
  String? image;
  String? name;
  String? degree;
  String? address;
  int? patient;
  int? experience;
  double? rate;
  String? category;
  String? workTime;
  String? location;
  int? price;
  String? desc;
  String? email;
  String? phone;
  String? doctorId;

  Vets({
    this.id,
    this.image,
    this.name,
    this.degree,
    this.address,
    this.patient,
    this.experience,
    this.rate,
    this.category,
    this.workTime,
    this.location,
    this.price,
    this.desc,
    this.email,
    this.phone,
    this.doctorId,
  });

  factory Vets.fromJson(Map<String, dynamic> json) {
    return Vets(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      degree: json['degree'],
      address: json['address'],
      patient: json['patient'],
      experience: json['experience'],
      rate: json['rate'],
      category: json['category'],
      workTime: json['workTime'],
      location: json['location'],
      price: json['price'],
      desc: json['desc'],
      email: json['email'],
      phone: json['phone'],
      doctorId: json['doctorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'degree': degree,
      'address': address,
      'patient': patient,
      'experience': experience,
      'rate': rate,
      'category': category,
      'workTime': workTime,
      'location': location,
      'price': price,
      'desc': desc,
      'email': email,
      'phone': phone,
      'doctorId': doctorId,
    };
  }

  Vets copyWith({
    String? id,
    String? image,
    String? name,
    String? degree,
    String? address,
    int? patient,
    int? experience,
    double? rate,
    String? category,
    String? workTime,
    String? location,
    int? price,
    String? desc,
    String? email,
    String? phone,
    String? doctorId,
  }) {
    return Vets(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      degree: degree ?? this.degree,
      address: address ?? this.address,
      patient: patient ?? this.patient,
      experience: experience ?? this.experience,
      rate: rate ?? this.rate,
      category: category ?? this.category,
      workTime: workTime ?? this.workTime,
      location: location ?? this.location,
      price: price ?? this.price,
      desc: desc ?? this.desc,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      doctorId: doctorId ?? this.doctorId,
    );
  }
}
