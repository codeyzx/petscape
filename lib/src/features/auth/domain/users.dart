class Users {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? roles;

  Users({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.roles,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'roles': roles,
    };
  }

  Users copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? roles,
  }) {
    return Users(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      roles: roles ?? this.roles,
    );
  }
}
