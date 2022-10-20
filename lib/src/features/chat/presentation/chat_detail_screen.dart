// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';
// import 'package:petscape/src/features/auth/presentation/auth_controller.dart';

// class ChatsDetailScreen extends ConsumerStatefulWidget {
//   final String? usersId;
//   final String? messagesId;
//   const ChatsDetailScreen({super.key, required this.usersId, required this.messagesId});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => ChatsDetailScreenState();
// }

// class ChatsDetailScreenState extends ConsumerState<ChatsDetailScreen> {
//   final textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(authControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey[800],
//         elevation: 0.0,
//         leading: Container(),
//         leadingWidth: 0.0,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             StreamBuilder<DocumentSnapshot<Object?>>(
//               stream: FirebaseFirestore.instance.collection("users").doc(widget.usersId).snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) return const Text("Error");
//                 if (!snapshot.hasData) return const Text("No Data");
//                 if (snapshot.data?.data() != null) {
//                   Map<String, dynamic> item = (snapshot.data!.data() as Map<String, dynamic>);
//                   item["id"] = snapshot.data!.id;
//                   return Row(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.all(12.0),
//                         child: CircleAvatar(backgroundColor: Colors.amber, backgroundImage: NetworkImage(item['photoUrl'])),
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item['name'],
//                               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(
//                               height: 4.0,
//                             ),
//                             Text(
//                               item['status'],
//                               style: const TextStyle(
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Icon(
//                         Icons.more_vert,
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const SizedBox();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.blueGrey[100],
//             height: double.infinity,
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("messages")
//                   .where('users', arrayContains: users.uid)
//                   .orderBy('timeSent', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   Logger().e(snapshot.error);
//                   return const Text("Error");
//                 }
//                 if (snapshot.data == null) return Container();
//                 if (snapshot.data!.docs.isEmpty) {
//                   return const Text("No Data");
//                 }
//                 final data = snapshot.data!;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.only(bottom: 80),
//                   itemCount: data.docs.length,
//                   itemBuilder: (context, index) {
//                     Map<String, dynamic> item = (data.docs[index].data() as Map<String, dynamic>);
//                     item["id"] = data.docs[index].id;
//                     return Column(
//                       children: [
//                         if (item["receiverId"] == users.uid)
//                           if (item["message"].isNotEmpty)
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               margin: const EdgeInsets.fromLTRB(10, 10, 100, 0),
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomRight: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                                 color: Colors.white,
//                               ),
//                               padding: const EdgeInsets.all(16),
//                               child: Text("${item["message"]}"),
//                             ),
//                         if (item["receiverId"] != users.uid)
//                           if (item["message"].isNotEmpty)
//                             Container(
//                               alignment: Alignment.centerRight,
//                               margin: const EdgeInsets.fromLTRB(100, 10, 10, 0),
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomRight: Radius.circular(20),
//                                   topRight: Radius.circular(20),
//                                 ),
//                                 color: Colors.greenAccent,
//                               ),
//                               padding: const EdgeInsets.all(16),
//                               child: Text("${item["message"]}"),
//                             ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: const Icon(
//                         Icons.add,
//                         color: Colors.grey,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   SizedBox(
//                     height: 50,
//                     width: 200,
//                     child: TextField(
//                       controller: textController,
//                       onChanged: (_) {
//                         FirebaseFirestore.instance.collection("users").doc(users.uid).update({
//                           "status": "typing...",
//                         });
//                       },
//                       onSubmitted: (value) async {
//                         if (value.isNotEmpty) {
//                           final db = FirebaseFirestore.instance.collection('messagez').doc();
//                           await FirebaseFirestore.instance.collection("users").doc(users.uid).update({
//                             "status": "Online",
//                           });
//                           await FirebaseFirestore.instance.collection('messages').add({
//                             "senderId": users.uid,
//                             "receiverId": widget.usersId,
//                             "users": [
//                               users.uid,
//                               widget.usersId,
//                             ],
//                             "message": textController.text,
//                             "timeSent": DateTime.now().millisecondsSinceEpoch,
//                             "isRead": false,
//                           });
//                           await db.set(
//                             {
//                               "author": {"id": users.uid},
//                               "createdAt": DateTime.now().millisecondsSinceEpoch,
//                               "id": db.id,
//                               "text": textController.text,
//                               "type": "text",
//                               "users": [
//                                 users.uid,
//                                 widget.usersId,
//                               ],
//                             },
//                           );
//                           await FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(users.uid)
//                               .collection('chats')
//                               .doc(widget.usersId)
//                               .update({
//                             "lastMessage": textController.text,
//                             "timeSent": DateTime.now().millisecondsSinceEpoch,
//                           });
//                           await FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(widget.usersId)
//                               .collection('chats')
//                               .doc(users.uid)
//                               .update({
//                             "lastMessage": textController.text,
//                             "timeSent": DateTime.now().millisecondsSinceEpoch,
//                           });
//                         }
//                       },
//                       decoration: const InputDecoration(
//                         hintText: "Message",
//                         hintStyle: TextStyle(color: Colors.black54),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: const Icon(
//                         Icons.attachment,
//                         color: Colors.grey,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12.0,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       // await FirebaseFirestore.instance.collection("users").doc(users.uid).collection('chats').add({
//                       //   "contacts": 'VBHgE9diwnVGz1xEWu6MQGYm73x2',
//                       //   "lastMessage": "",
//                       //   "timeSent": "",
//                       // });
//                     },
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: const Icon(
//                         Icons.mic,
//                         color: Colors.grey,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String? usersId;
  final String? messagesId;
  const ChatDetailScreen({super.key, required this.usersId, required this.messagesId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final textController = TextEditingController();
  List<types.Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    final user = types.User(id: users.uid.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
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
                        padding: EdgeInsets.only(
                          right: 12.w,
                        ),
                        child: CircleAvatar(backgroundImage: NetworkImage(item['photoUrl'])),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Text(
                              item['status'],
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .where('users', arrayContains: users.uid)
            .where('messagesId', isEqualTo: widget.messagesId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // if (snapshot.hasError) {
          //   Logger().e(snapshot.error);
          //   return const Text("Error");
          // }
          // if (snapshot.data == null) return Container();
          // if (snapshot.data!.docs.isEmpty) {
          //   return const Text("No Data");
          // }
          final data = snapshot.data;

          final messages = data?.docs.map((e) {
            final json = e.data() as Map<String, dynamic>;
            return types.Message.fromJson(json);
          }).toList();
          return Chat(
            theme: const DefaultChatTheme(
              primaryColor: Colors.redAccent,
            ),
            messages: messages ?? [],
            onAttachmentPressed: _handleAttachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            customBottomWidget: Container(
              margin: const EdgeInsets.only(
                bottom: 5.0,
                left: 15.0,
                right: 15.0,
              ),
              height: 61,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: const [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.face,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {}),
                          Expanded(
                            child: TextField(
                              onSubmitted: (value) async {
                                if (value.isNotEmpty) {
                                  await FirebaseFirestore.instance.collection("users").doc(users.uid).update({
                                    "status": "Online",
                                  });

                                  final messagesCollection = FirebaseFirestore.instance.collection('messages').doc();
                                  await messagesCollection.set(
                                    {
                                      'messagesId': widget.messagesId,
                                      "id": messagesCollection.id,
                                      "author": {"id": users.uid},
                                      'isRead': false,
                                      "text": textController.text,
                                      "type": "text",
                                      "createdAt": DateTime.now().millisecondsSinceEpoch,
                                      "senderId": users.uid,
                                      "receiverId": widget.usersId,
                                      "users": [
                                        users.uid,
                                        widget.usersId,
                                      ],
                                    },
                                  );

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

                                  textController.clear();
                                }
                              },
                              controller: textController,
                              onChanged: (_) {
                                FirebaseFirestore.instance.collection("users").doc(users.uid).update({
                                  "status": "typing...",
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Type Something...",
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.photo_camera, color: Colors.redAccent),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.attach_file, color: Colors.redAccent),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                    child: InkWell(
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onTap: () async {
                        if (textController.text.isNotEmpty) {
                          await FirebaseFirestore.instance.collection("users").doc(users.uid).update({
                            "status": "Online",
                          });

                          final messagesCollection = FirebaseFirestore.instance.collection('messages').doc();
                          await messagesCollection.set(
                            {
                              'messagesId': widget.messagesId,
                              "id": messagesCollection.id,
                              "author": {"id": users.uid},
                              'isRead': false,
                              "text": textController.text,
                              "type": "text",
                              "createdAt": DateTime.now().millisecondsSinceEpoch,
                              "senderId": users.uid,
                              "receiverId": widget.usersId,
                              "users": [
                                users.uid,
                                widget.usersId,
                              ],
                            },
                          );

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

                          textController.clear();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            onSendPressed: (_) {},
            // showUserAvatars: true,
            // showUserNames: true,

            user: user,
          );
        },
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final user = types.User(id: widget.usersId!);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final user = types.User(id: widget.usersId!);
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index = _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage = (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index = _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage = (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handleSendPressed(types.PartialText message) {
    print('object'); // final textMessage = types.TextMessage(
    //   author: _user,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   id: const Uuid().v4(),
    //   text: message.text,
    // );

    // _addMessage(textMessage);
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _loadMessages() async {
    // final response = await rootBundle.loadString('assets/messages.json');
    // final messages = (jsonDecode(response) as List).map((e) => types.Message.fromJson(e as Map<String, dynamic>)).toList();

    final db = FirebaseFirestore.instance.collection('messages');
    final data = await db.get();
    final messages = data.docs.map((e) => types.Message.fromJson(e.data())).toList();

    setState(() {
      _messages = messages;
    });
  }
}
