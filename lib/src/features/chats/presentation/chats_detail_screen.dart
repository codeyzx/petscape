import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';

class ChatsDetailScreen extends ConsumerStatefulWidget {
  final String? usersId;
  final String? messagesId;
  const ChatsDetailScreen({super.key, required this.usersId, required this.messagesId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChatsDetailScreenState();
}

class ChatsDetailScreenState extends ConsumerState<ChatsDetailScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        elevation: 0.0,
        leading: Container(),
        leadingWidth: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot<Object?>>(
              stream: FirebaseFirestore.instance.collection("users").doc(widget.usersId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Error");
                if (!snapshot.hasData) return const Text("No Data");
                if (snapshot.data?.data() != null) {
                  Map<String, dynamic> item = (snapshot.data!.data() as Map<String, dynamic>);
                  item["id"] = snapshot.data!.id;
                  return Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12.0),
                        child: CircleAvatar(backgroundColor: Colors.amber, backgroundImage: NetworkImage(item['photoUrl'])),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              item['status'],
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueGrey[100],
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .where('users', arrayContains: users.uid)
                  .orderBy('timeSent', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Logger().e(snapshot.error);
                  return const Text("Error");
                }
                if (snapshot.data == null) return Container();
                if (snapshot.data!.docs.isEmpty) {
                  return const Text("No Data");
                }
                final data = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = (data.docs[index].data() as Map<String, dynamic>);
                    item["id"] = data.docs[index].id;
                    return Column(
                      children: [
                        if (item["receiverId"] == users.uid)
                          if (item["message"].isNotEmpty)
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.fromLTRB(10, 10, 100, 0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text("${item["message"]}"),
                            ),
                        if (item["receiverId"] != users.uid)
                          if (item["message"].isNotEmpty)
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.fromLTRB(100, 10, 10, 0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.greenAccent,
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text("${item["message"]}"),
                            ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TextField(
                      controller: textController,
                      onChanged: (_) {
                        FirebaseFirestore.instance.collection("users").doc(users.uid).update({
                          "status": "typing...",
                        });
                      },
                      onSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          await FirebaseFirestore.instance.collection("users").doc(users.uid).update({
                            "status": "Online",
                          });
                          await FirebaseFirestore.instance.collection('messages').add({
                            "senderId": users.uid,
                            "receiverId": widget.usersId,
                            "users": [
                              users.uid,
                              widget.usersId,
                            ],
                            "message": textController.text,
                            "timeSent": DateTime.now().millisecondsSinceEpoch,
                            "isRead": false,
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(users.uid)
                              .collection('chats')
                              .doc(widget.usersId)
                              .update({
                            "lastMessage": textController.text,
                            "timeSent": DateTime.now().millisecondsSinceEpoch,
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.usersId)
                              .collection('chats')
                              .doc(users.uid)
                              .update({
                            "lastMessage": textController.text,
                            "timeSent": DateTime.now().millisecondsSinceEpoch,
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Message",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.attachment,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // await FirebaseFirestore.instance.collection("users").doc(users.uid).collection('chats').add({
                      //   "contacts": 'VBHgE9diwnVGz1xEWu6MQGYm73x2',
                      //   "lastMessage": "",
                      //   "timeSent": "",
                      // });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
