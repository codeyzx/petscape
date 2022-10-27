import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/chat/presentation/chat_controller.dart';
import 'package:petscape/src/features/chat/presentation/chat_detail_screen.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/booking_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';

class VetsDetailScreen extends ConsumerStatefulWidget {
  final String usersId;
  final Vets vets;
  const VetsDetailScreen({Key? key, required this.usersId, required this.vets}) : super(key: key);

  @override
  ConsumerState<VetsDetailScreen> createState() => _VetsDetailScreenState();
}

class _VetsDetailScreenState extends ConsumerState<VetsDetailScreen> {
  bool _isLoved = false;

  late Vets vets;
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    vets = widget.vets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitish,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: Container(
          decoration: BoxDecoration(color: whitish, boxShadow: [
            buildPrimaryBoxShadow(),
          ]),
          padding: EdgeInsets.only(top: 20.h, right: 18.w, bottom: 10.h, left: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/icons/arrow-left-icon.png"),
              ),
              Text(
                "Doctor Details",
                style: appBarTitle,
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/icons/date-icon.png",
                  scale: 4,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
              vets.image.toString(),
              width: 1.sw,
              height: 252.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "Dr. Naegha Blak",
                        vets.name.toString(),
                        style: vetDetailName,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: SizedBox(
                          width: 36.w,
                          height: 36.h,
                          child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoved = true;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.all(6),
                                side: BorderSide(
                                  width: 2.w,
                                  color: primary,
                                ),
                              ),
                              child: Image.asset(_isLoved == true
                                  ? "assets/icons/love-fill-icon.png"
                                  : "assets/icons/love-not-fill-icon.png")),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    // "Cat Specialist",
                    vets.degree.toString(),
                    style: vetDetailJob,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Margahayu Raya, Bandung, Jawa Barat",
                    vets.address.toString(),
                    style: vetDetailLocation,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 4.h, left: 6.w),
                        width: 102.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: whitish,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: gray,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pasien",
                              style: vetDetailIDTitle,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/people-icon.png",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  // "10.000+",
                                  vets.patient.toString(),
                                  style: vetDetailIDBig,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4.h, left: 6.w),
                        width: 102.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: whitish,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: gray,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pengalaman",
                              style: vetDetailIDTitle,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/medkit-icon.png",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  // "5 Tahun",
                                  '${vets.experience} Tahun',
                                  style: vetDetailIDBig,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4.h, left: 6.w),
                        width: 102.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: whitish,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: gray,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rating",
                              style: vetDetailIDTitle,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/rating-icon.png",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  // "4.5",
                                  vets.rate.toString(),
                                  style: vetDetailIDBig,
                                ),
                                Text(
                                  "/5",
                                  style: vetDetailIDBigGray,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 1.sw,
              height: 1.h,
              color: gray,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doctor Description",
                    style: productDescBigTitle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kategori:",
                        style: productDescSubTitleBlack,
                      ),
                      Text(
                        // "Kucing",
                        vets.category.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jam Kerja:",
                        style: productDescSubTitleBlack,
                      ),
                      Text(
                        // "10:00-20:00",
                        vets.workTime.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lokasi:",
                        style: productDescSubTitleBlack,
                      ),
                      Text(
                        // "Bandung",
                        vets.location.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estimasi Biaya:",
                        style: productDescSubTitleBlack,
                      ),
                      Text(
                        // "Rp80.000-Rp100.000",
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(vets.price),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "About Doctor",
                    style: productDescBigTitle,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit faucibus amet nullam cras volutpat. Consectetur dignissim lorem condimentum arcu sit. Ridiculus malesuada dolor ultrices semper erat suscipit eget.",
                    vets.desc.toString(),
                    style: productDescText,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Kontak",
                    style: productDescBigTitle,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/message-icon.png",
                        width: 34.w,
                        height: 34.h,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        // "tracyf12@gmail.com",
                        vets.email.toString(),
                        style: vetDetailContact,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/phone-call-icon.png",
                        width: 34.w,
                        height: 34.h,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        // "+6282147955328",
                        '+62${vets.phone}',
                        style: vetDetailContact,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 106.h,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        width: 1.sw,
        height: 72.h,
        decoration: BoxDecoration(color: whitish, boxShadow: [
          buildSecondaryBoxShadow(),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 118.w,
                height: 42.h,
                child: OutlinedButton(
                  onPressed: () async {
                    final String doctorId = vets.doctorId.toString();
                    final check = await ref
                        .read(chatControllerProvider.notifier)
                        .checkChat(usersId: widget.usersId, contactId: doctorId);
                    if (check) {
                      final messagesId = await ref
                          .read(chatControllerProvider.notifier)
                          .getMessagesId(usersId: widget.usersId, contactId: doctorId);

                      if (!mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatDetailScreen(usersId: doctorId, messagesId: messagesId, isDoctor: true),
                          ));
                    } else {
                      await ref.read(chatControllerProvider.notifier).createChat(
                            usersId: widget.usersId,
                            contactId: doctorId,
                          );

                      final messagesId = await ref
                          .read(chatControllerProvider.notifier)
                          .getMessagesId(usersId: widget.usersId, contactId: doctorId);

                      if (!mounted) return;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(usersId: doctorId, messagesId: messagesId),
                          ));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 1.w,
                      color: primary,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/chat-primary-icon.png",
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Chat",
                        style: productKeranjang,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 197.w,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingScreen(
                                vets: vets,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  child: Text(
                    "Make Appointment",
                    style: productBuy,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
