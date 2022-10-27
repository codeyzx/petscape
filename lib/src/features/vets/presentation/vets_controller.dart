import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';

class VetsController extends StateNotifier<List<Vets>> {
  VetsController() : super(const []);

  final db = FirebaseFirestore.instance.collection('vets').withConverter(
        fromFirestore: (snapshot, _) => Vets.fromJson(snapshot.data()!),
        toFirestore: (Vets vets, _) => vets.toJson(),
      );

  Future<void> add(Vets vets) async {
    final ref = db.doc();
    final temp = vets.copyWith(id: ref.id);
    await db.add(temp);
    await getData();
  }

  Future<void> getData() async {
    final data = await db.get();
    state = data.docs.map((e) => e.data()).toList();
  }
}

final vetsControllerProvider = StateNotifierProvider<VetsController, List<Vets>>(
  (ref) => VetsController(),
);
