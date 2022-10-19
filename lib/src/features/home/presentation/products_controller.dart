import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/home/domain/products/products.dart';

class ProductsController extends StateNotifier<List<Products>> {
  ProductsController() : super(const []);

  final db = FirebaseFirestore.instance.collection('products');

  Future<void> add(Products products) async {
    final docRef = db.withConverter(
      fromFirestore: (snapshot, _) => Products.fromJson(snapshot.data()!),
      toFirestore: (Products products, _) => products.toJson(),
    );
    await docRef.add(products);
    await getData();
  }

  Future<void> getData() async {
    final docRef = db.withConverter(
      fromFirestore: (snapshot, _) => Products.fromJson(snapshot.data()!),
      toFirestore: (Products products, _) => products.toJson(),
    );
    final data = await docRef.get();
    state = data.docs.map((e) => e.data()).toList();
  }
}

final productsControllerProvider = StateNotifierProvider<ProductsController, List<Products>>(
  (ref) => ProductsController(),
);
