import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/order/domain/pet/pet.dart';

class PetController extends StateNotifier<List<Pet>> {
  PetController() : super(const []);

  final db = FirebaseFirestore.instance.collection('pets').withConverter(
        fromFirestore: (snapshot, _) => Pet.fromJson(snapshot.data()!),
        toFirestore: (Pet pet, _) => pet.toJson(),
      );

  Future<void> getData(String usersId) async {
    final data = await db.where('usersId', isEqualTo: usersId).get();
    state = data.docs.map((e) => e.data()).toList();
  }

  Future<String> add({required String usersId, required Pet pet}) async {
    final ref = db.doc();
    final temp = pet.copyWith(id: ref.id, usersId: usersId);
    await ref.set(temp);
    return ref.id;
  }

  Future<void> update({required Pet pet}) async {
    final ref = db.doc(pet.id);
    await ref.update(pet.toJson());
  }

  Future<String> uploadImages(String imagesPath) async {
    final value = await FirebaseStorage.instance.ref().child('pet/${DateTime.now()}.png').putFile(File(imagesPath));
    return value.ref.getDownloadURL();
  }

  Future<void> addHistoryHealth({required String id, required Map<String, dynamic> history}) async {
    final ref = db.doc(id);
    final data = await ref.get();
    await ref.update({
      'health': FieldValue.arrayUnion([...data.data()!.health ?? [], history]),
    });
  }
}

final petControllerProvider = StateNotifierProvider<PetController, List<Pet>>(
  (ref) => PetController(),
);
