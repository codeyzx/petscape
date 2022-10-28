import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/chat/presentation/chat_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  Users? userz;

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: whitish,
      appBar: AppBar(
        primary: true,
        backgroundColor: whitish,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("assets/icons/arrow-left-icon.png"),
        ),
        title: Text(
          "Chat",
          style: appBarTitle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 324.w,
                  child: PhysicalModel(
                    color: HexColor('#FFFDF9'),
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10.r),
                    shadowColor: Colors.black.withOpacity(0.5),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          height: 3.2.h,
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search_rounded),
                          onPressed: () {},
                        ),
                        iconColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: "Search Something",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
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
                  return const Text("No Data ");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            width: 64.w,
                            height: 56.h,
                            decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r)),
                          ),
                        ),
                      );
                    },
                  );
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
                              return const Text("No Data 1");
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

                                return data.data()!['roles'] != 'doctor'
                                    ? Column(
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
                                                      builder: (context) => ChatDetailScreen(
                                                        usersId: data.id,
                                                        messagesId: item['messagesId'],
                                                      ),
                                                    ));
                                              }
                                            },
                                            child: ListTile(
                                              contentPadding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 5.h),
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage: NetworkImage(data.data()!['photoUrl']),
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Text(
                                                  data.data()!['name'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              subtitle: readLength != 0
                                                  ? Text(
                                                      item['lastMessage'],
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      item['lastMessage'],
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                              trailing: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      formatDate(item['timeSent']),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: readLength != 0 ? Colors.black : Colors.grey,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 7.0,
                                                    ),
                                                    readLength != 0
                                                        ? CircleAvatar(
                                                            backgroundColor: Colors.red,
                                                            radius: 12.0,
                                                            child: Text(
                                                              readLength.toString(),
                                                              style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(
                                                            height: 23,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
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
                                                      builder: (context) => ChatDetailScreen(
                                                        usersId: data.id,
                                                        messagesId: item['messagesId'],
                                                        isDoctor: true,
                                                      ),
                                                    ));
                                              }
                                            },
                                            child: ListTile(
                                              contentPadding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 5.h),
                                              leading: CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage: NetworkImage(data.data()!['doctorImage']),
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      data.data()!['doctorName'],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Image.asset(
                                                      'assets/icons/doctor-icon.png',
                                                      height: 16.h,
                                                      width: 16.w,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              subtitle: readLength != 0
                                                  ? Text(
                                                      item['lastMessage'],
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    )
                                                  : Text(
                                                      item['lastMessage'],
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                              trailing: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      formatDate(item['timeSent']),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: readLength != 0 ? Colors.black : Colors.grey,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 7.0,
                                                    ),
                                                    readLength != 0
                                                        ? CircleAvatar(
                                                            backgroundColor: Colors.red,
                                                            radius: 12.0,
                                                            child: Text(
                                                              readLength.toString(),
                                                              style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(
                                                            height: 23,
                                                          ),
                                                  ],
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

  String formatDate(int epoch) {
    final date = DateTime.fromMillisecondsSinceEpoch(epoch);
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) {
      return DateFormat('dd MMM').format(date);
    } else if (difference.inDays > 1) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('Hm').format(date);
    }
  }
}
