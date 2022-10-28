import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';

class OrderController extends StateNotifier<List<Order>> {
  OrderController() : super(const []);

  final db = FirebaseFirestore.instance.collection('orders').withConverter(
        fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
        toFirestore: (Order order, _) => order.toJson(),
      );

  Future<void> add({required String usersId, required Order order}) async {
    final ref = db.doc();
    final temp = order.copyWith(id: ref.id);
    await db.add(temp);
    await getData(usersId);
  }

  Future<void> patientIncrement(String docId) async {
    final doc = await FirebaseFirestore.instance.collection('vets').doc(docId).get();
    final data = doc.data()!;
    final patient = data['patient'] + 1;
    await FirebaseFirestore.instance.collection('vets').doc(docId).update({'patient': patient});
  }

  Future<void> buy(List<Map<String, int>> items) async {
    Future.wait(
      items.map((e) async {
        final doc = await FirebaseFirestore.instance.collection('products').doc(e.keys.first).get();
        final data = doc.data()!;
        final qty = data['stock'] - e.values.first;
        final sold = data['sold'] + 1;
        await FirebaseFirestore.instance.collection('products').doc(e.keys.first).update({'stock': qty, 'sold': sold});
      }).toList(),
    );
  }

  Future<void> getData(String usersId) async {
    final data = await db.where('customerId', isEqualTo: usersId).get();
    state = data.docs.map((e) => e.data()).toList();
  }
}

final orderControllerProvider = StateNotifierProvider<OrderController, List<Order>>(
  (ref) => OrderController(),
);
