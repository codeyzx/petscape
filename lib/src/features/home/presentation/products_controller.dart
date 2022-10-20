import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';

class ProductController extends StateNotifier<List<Product>> {
  ProductController() : super(const []);

  final db = FirebaseFirestore.instance.collection('products');

  Future<void> add(Product products) async {
    final docRef = db.withConverter(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (Product products, _) => products.toJson(),
    );
    await docRef.add(products);
    await getData();
  }

  Future<void> getData() async {
    final docRef = db.withConverter(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (Product products, _) => products.toJson(),
    );
    final data = await docRef.get();
    state = data.docs.map((e) => e.data()).toList();
  }
}

final productsControllerProvider = StateNotifierProvider<ProductController, List<Product>>(
  (ref) => ProductController(),
);
