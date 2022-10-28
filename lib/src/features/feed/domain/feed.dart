class Feed {
  String? id;
  String? username;
  String? userId;
  String? userphoto;
  int? createdAt;
  String? type;
  String? photo;
  String? content;
  String? category;
  String? title;
  String? description;
  int? donationTarget;
  int? donationTotal;
  String? typeBank;
  String? accountBank;

  Feed({
    this.id,
    this.username,
    this.userId,
    this.userphoto,
    this.createdAt,
    this.type,
    this.photo,
    this.content,
    this.category,
    this.title,
    this.description,
    this.donationTarget,
    this.donationTotal,
    this.typeBank,
    this.accountBank,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      username: json['username'],
      userId: json['userId'],
      userphoto: json['userphoto'],
      createdAt: json['createdAt'],
      type: json['type'],
      photo: json['photo'],
      content: json['content'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      donationTarget: json['donationTarget'],
      donationTotal: json['donationTotal'],
      typeBank: json['typeBank'],
      accountBank: json['accountBank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userId': userId,
      'userphoto': userphoto,
      'createdAt': createdAt,
      'type': type,
      'photo': photo,
      'content': content,
      'category': category,
      'title': title,
      'description': description,
      'donationTarget': donationTarget,
      'donationTotal': donationTotal,
      'typeBank': typeBank,
      'accountBank': accountBank,
    };
  }

  Feed copyWith({
    String? id,
    String? username,
    String? userId,
    String? userphoto,
    int? createdAt,
    String? type,
    String? photo,
    String? content,
    String? category,
    String? title,
    String? description,
    int? donationTarget,
    int? donationTotal,
    String? typeBank,
    String? accountBank,
  }) {
    return Feed(
      id: id ?? this.id,
      username: username ?? this.username,
      userId: userId ?? this.userId,
      userphoto: userphoto ?? this.userphoto,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      photo: photo ?? this.photo,
      content: content ?? this.content,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      donationTarget: donationTarget ?? this.donationTarget,
      donationTotal: donationTotal ?? this.donationTotal,
      typeBank: typeBank ?? this.typeBank,
      accountBank: accountBank ?? this.accountBank,
    );
  }
}
