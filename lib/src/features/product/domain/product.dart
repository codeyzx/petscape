class Product {
  String? id;
  String? type;
  String? name;
  String? image;
  String? category;
  String? seller;
  String? location;
  String? desc;
  int? stock;
  int? price;
  int? qty;
  int? sold;

  Product({
    this.id,
    this.type,
    this.name,
    this.image,
    this.category,
    this.seller,
    this.location,
    this.desc,
    this.stock,
    this.price,
    this.qty,
    this.sold,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      category: json['category'],
      seller: json['seller'],
      location: json['location'],
      desc: json['desc'],
      stock: json['stock'],
      price: json['price'],
      qty: json['qty'],
      sold: json['sold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'image': image,
      'category': category,
      'seller': seller,
      'location': location,
      'desc': desc,
      'stock': stock,
      'price': price,
      'qty': qty,
      'sold': sold,
    };
  }
}
