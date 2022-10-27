import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';

class ChatController extends StateNotifier<List<Vets>> {
  ChatController() : super(const []);

  final db = FirebaseFirestore.instance;

  Future<bool> checkChat({required String usersId, required String contactId}) async {
    final data = await db.collection('users').doc(usersId).collection('chats').doc(contactId).get();
    return data.exists;
  }

  Future<void> createChat({required String usersId, required String contactId}) async {
    final messagesDoc = FirebaseFirestore.instance.collection('messages').doc();

    await db.collection('users').doc(usersId).collection('chats').doc(contactId).set({
      'messagesId': messagesDoc.id,
      'contacts': contactId,
      'lastMessage': '',
      'timeSent': '',
    });
    await db.collection('users').doc(contactId).collection('chats').doc(usersId).set({
      'messagesId': messagesDoc.id,
      'contacts': usersId,
      'lastMessage': '',
      'timeSent': '',
    });
  }

  Future<String> getMessagesId({required String usersId, required String contactId}) async {
    final data = await db.collection('users').doc(usersId).collection('chats').doc(contactId).get();
    return data['messagesId'];
  }

  // Future<void> add(Vets vets) async {
  //   final ref = db.doc();
  //   final temp = vets.copyWith(id: ref.id);
  //   await db.add(temp);
  //   await getData();
  // }

  // Future<void> getData() async {
  //   final data = await db.get();
  //   state = data.docs.map((e) => e.data()).toList();
  // }
}

final chatControllerProvider = StateNotifierProvider<ChatController, List<Vets>>(
  (ref) => ChatController(),
);
