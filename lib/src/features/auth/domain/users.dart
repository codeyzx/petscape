// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'users.freezed.dart';
// part 'users.g.dart';

// @freezed
// abstract class Users with _$Users {
//   const factory Users({
//     @JsonKey(name: 'uid') String? uid,
//     @JsonKey(name: 'name') String? name,
//     @JsonKey(name: 'email') String? email,
//     @JsonKey(name: 'photoUrl') String? photoUrl,
//     @JsonKey(name: 'roles') String? roles,
//   }) = _Users;

//   factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

//   // factory Users.fromFirestore(
//   //   DocumentSnapshot<Map<String, dynamic>> snapshot,
//   //   SnapshotOptions? options,
//   // ) {
//   //   final data = snapshot.data();
//   //   return Users(
//   //     name: data?['name'],
//   //     email: data?['email'],
//   //   );
//   // }

//   // Map<String, dynamic> toFirestore() {
//   //   return {
//   //     if (name != null) 'name': name,
//   //     if (email != null) 'email': email,
//   //   };
//   // }

// }

// create class model users
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
