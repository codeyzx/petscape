import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String? usersId;
  final String? messagesId;
  final bool? isDoctor;
  const ChatDetailScreen({super.key, required this.usersId, required this.messagesId, this.isDoctor});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final textController = TextEditingController();
  final List<types.Message> _messages = [];

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
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                          widget.isDoctor == null ? item['photoUrl'] : item['doctorImage'],
                        )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isDoctor == null ? item['name'] : item['doctorName'],
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
                            onPressed: () async {},
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
}
