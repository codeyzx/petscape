import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/chats/presentation/chats_detail_screen.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  Users? userz;

  @override
  Widget build(BuildContext context) {
    List chatList = [
      {
        "name": "Danniel Radclife",
        "avatar_url": "https://i.ibb.co/PGv8ZzG/me.jpg",
        "last_message": "Thanks for the update",
        "time": "10:04",
        "pin": true,
      },
      {
        "name": "May",
        "avatar_url":
            "https://images.unsplash.com/photo-1592621385612-4d7129426394?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d29tYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
        "last_message": "Hehe, ok",
        "time": "09:04",
        "pin": true,
      },
      {
        "name": "Jessica Jane",
        "avatar_url":
            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
        "last_message": "Hi, can u check your email",
        "time": "08:22",
        "pin": true,
      },
      {
        "name": "Keanue Reeve",
        "avatar_url":
            "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "last_message": "I've pushed the update",
        "time": "1 Day Ago",
      },
      {
        "name": "Donnie Yen",
        "avatar_url":
            "https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG1hbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
        "last_message": "Ok, i`ll back",
        "time": "1 Day Ago",
      }
    ];

    final users = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0.0,
        backgroundColor: Colors.blueGrey[700],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
        ),
        title: const Text("Chat"),
        actions: [
          InkWell(
            onTap: () => {},
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                const userzId = '5zO2fO0QNNWxIqDSCjs9jSBEucB2';
                final db = FirebaseFirestore.instance.collection('messages').doc();
                await FirebaseFirestore.instance.collection("users").doc(users.uid).collection('chats').doc(userzId).set({
                  "contacts": userzId,
                  "messagesId": db.id,
                  "lastMessage": "",
                  "timeSent": "",
                });
                await FirebaseFirestore.instance.collection("users").doc(userzId).collection('chats').doc(users.uid).set({
                  "contacts": users.uid,
                  "messagesId": db.id,
                  "lastMessage": "",
                  "timeSent": "",
                });
              },
              child: const Text('Add Data')),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(users.uid)
                  .collection('chats')
                  .where('lastMessage', isNotEqualTo: "")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Error");
                if (snapshot.data == null) return Container();
                if (snapshot.data!.docs.isEmpty) {
                  return const Text("No Data");
                }
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = (data.docs[index].data() as Map<String, dynamic>);
                    item["id"] = data.docs[index].id;
                    return Column(
                      children: [
                        FutureBuilder(
                          future: FirebaseFirestore.instance.collection("users").doc(item["contacts"]).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return const Text("Error");
                            if (snapshot.data == null) return Container();
                            if (snapshot.data!.data() == null) {
                              return const Text("No Data");
                            }
                            final data = snapshot.data!;

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("messages")
                                  .where('receiverId', isEqualTo: users.uid)
                                  .snapshots(),
                              builder: (context, snapshot2) {
                                if (snapshot2.hasError) return const Text("Error");
                                if (snapshot2.data == null) return Container();
                                if (snapshot2.data!.docs.isEmpty) {
                                  return const Text("No Data");
                                }

                                final readDocs = snapshot2.data!.docs.map((e) {
                                  final temp = e.data() as Map<String, dynamic>;
                                  if (temp['isRead'] == false) {
                                    return e.id;
                                  } else {
                                    return 0;
                                  }
                                }).toList();
                                final reads = readDocs.where((element) => element != 0).toList();
                                final readLength = reads.length;

                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Future.wait((reads).map(
                                          (e) {
                                            return FirebaseFirestore.instance
                                                .collection("messages")
                                                .doc(e.toString())
                                                .update({
                                              "isRead": true,
                                            });
                                          },
                                        ));
                                        if (mounted) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatsDetailScreen(
                                                  usersId: data.id,
                                                  messagesId: item['messagesId'],
                                                ),
                                              ));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          top: 6.0,
                                          bottom: 6.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: const CircleAvatar(
                                            radius: 30.0,
                                          ),
                                          title: Text(
                                            data.data()!['name'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(item['lastMessage']),
                                          trailing: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.fromMillisecondsSinceEpoch(item["timeSent"])),
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  height: 6.0,
                                                ),
                                                if (readLength != 0)
                                                  CircleAvatar(
                                                      backgroundColor: Colors.redAccent,
                                                      radius: 12.0,
                                                      child: Text(
                                                        readLength.toString(),
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.white, fontWeight: FontWeight.bold),
                                                      )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
