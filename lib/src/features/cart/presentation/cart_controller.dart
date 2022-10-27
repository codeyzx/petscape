import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/product/domain/product.dart';

class CartController extends StateNotifier<List<Map<Product, int>>> {
  CartController() : super(const []);

  int cartsLength = 0;
  final db = FirebaseFirestore.instance.collection('carts');

  Future<void> deleteItem(String docId, Product product) async {
    final snapshot = await db.doc(docId).get();
    Map<String, dynamic> item = (snapshot.data() as Map<String, dynamic>);
    final data = item['items'];
    final index = data.indexWhere((e) => e['id'] == product.id);
    data.removeAt(index);
    await db.doc(docId).update({'items': data});
    await getData(docId);
  }

  Future<void> deleteListItem(String docId, List<Product> product) async {
    final snapshot = await db.doc(docId).get();
    Map<String, dynamic> item = (snapshot.data() as Map<String, dynamic>);
    final data = item['items'];
    for (var i = 0; i < product.length; i++) {
      final index = data.indexWhere((e) => e['id'] == product[i].id);
      data.removeAt(index);
    }
    await db.doc(docId).update({'items': data});
    await getData(docId);
  }

  Future<void> getData(String docId) async {
    final data = await db.doc(docId).get();
    final carts = data.data()!;
    final items = carts['items'];

    final List<Map<Product, int>> mapProducts = [];
    final Map<String, int> itemsMap = {for (var e in items) e['id']: e['qty']};
    final List<String> id = itemsMap.keys.toList();
    final List<int> qty = itemsMap.values.toList();

    final snapshot =
        await Future.wait(id.map((e) => FirebaseFirestore.instance.collection("products").doc(e).get()).toList());

    final list = snapshot.map((e) => e.data()).toList();
    final List<Product> products = list.map((e) => Product.fromJson(e!)).toList();

    for (int i = 0; i < products.length; i++) {
      mapProducts.add({products[i]: qty[i]});
    }

    await getCartsLength(docId);

    state = mapProducts;
  }

  Future<void> getCartsLength(String id) async {
    final snapshot = await db.doc(id).get();
    Map<String, dynamic> item = (snapshot.data() as Map<String, dynamic>);
    final data = item['items'];
    if (data.length > 0) {
      cartsLength = data.length;
    } else {
      cartsLength = 0;
    }
  }

  Future<void> decrementItem(String docId, Product product) async {
    final snapshot = await db.doc(docId).get();
    Map<String, dynamic> item = (snapshot.data() as Map<String, dynamic>);
    final data = item['items'];
    final index = data.indexWhere((e) => e['id'] == product.id);
    final qty = data[index]['qty'];
    if (qty > 1) {
      data[index]['qty'] = qty - 1;
    } else {
      data.removeAt(index);
    }
    await db.doc(docId).update({'items': data});
    await getData(docId);
  }

  Future<void> incrementItem(String docId, Product product) async {
    final snapshot = await db.doc(docId).get();
    Map<String, dynamic> item = (snapshot.data() as Map<String, dynamic>);
    final data = item['items'];
    final index = data.indexWhere((e) => e['id'] == product.id);
    final qty = data[index]['qty'];
    data[index]['qty'] = qty + 1;
    await db.doc(docId).update({'items': data});
    await getData(docId);
  }
}

final cartControllerProvider = StateNotifierProvider<CartController, List<Map<Product, int>>>(
  (ref) => CartController(),
);
