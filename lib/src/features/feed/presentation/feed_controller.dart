import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/feed/domain/feed.dart';

class FeedController extends StateNotifier<List<Feed>> {
  FeedController() : super(const []);

  final db = FirebaseFirestore.instance.collection('feed').withConverter(
        fromFirestore: (snapshot, _) => Feed.fromJson(snapshot.data()!),
        toFirestore: (Feed feed, _) => feed.toJson(),
      );

  Future<void> add(Feed feed) async {
    final ref = db.doc();
    final temp = feed.copyWith(id: ref.id);
    await ref.set(temp);
    await getData();
  }

  Future<void> getData() async {
    final data = await db.get();
    state = data.docs.map((e) => e.data()).toList();
  }

  Future<void> increment({required String id, required int value}) async {
    final ref = db.doc(id);
    final data = await ref.get();
    final feed = data.data();
    await ref.update({'donationTotal': feed!.donationTotal! + value});
    await getData();
  }
}

final feedControllerProvider = StateNotifierProvider<FeedController, List<Feed>>(
  (ref) => FeedController(),
);
