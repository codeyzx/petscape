import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/product/domain/product.dart';

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

  Future<List<Product>> getListData(List<String> docId) async {
    final data = await db.where(FieldPath.documentId, whereIn: docId).get();
    final carts = data.docs;
    final List<Product> products = [];
    for (var i = 0; i < carts.length; i++) {
      final item = carts[i].data();
      final product = Product.fromJson(item);
      products.add(product);
    }
    return products;
  }
}

final productControllerProvider = StateNotifierProvider<ProductController, List<Product>>(
  (ref) => ProductController(),
);
