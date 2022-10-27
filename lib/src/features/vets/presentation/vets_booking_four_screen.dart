import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/history_health/history_health.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/order/domain/pet/pet.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/order/presentation/pet_controller.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/booking_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class VetsBookingFourScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> appointment;
  final Map<String, String> address;
  final Map<String, String> timePlace;
  final String usersId;
  final Vets vets;
  final Pet pet;

  const VetsBookingFourScreen(
      {Key? key,
      required this.appointment,
      required this.address,
      required this.timePlace,
      required this.usersId,
      required this.vets,
      required this.pet})
      : super(key: key);

  @override
  ConsumerState<VetsBookingFourScreen> createState() => _VetsBookingFourScreenState();
}

class _VetsBookingFourScreenState extends ConsumerState<VetsBookingFourScreen> {
  @override
  Widget build(BuildContext context) {
    final formatTime = '${DateFormat(
      'EEEE, d MMMM',
    ).format(DateTime.parse(widget.timePlace['date'].toString()))} | ${widget.timePlace['time']} WIB';
    return Scaffold(
      backgroundColor: neutral,
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
                "Booking Appointment",
                style: appBarTitle,
              ),
              Container(
                width: 29.w,
                height: 29.h,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Booking Confirmation",
                style: vetBookTitle,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Step 4/4",
                style: vetBookPart,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Doctor Information",
                style: vetBookInputLabel,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w),
                width: 324.w,
                height: 78.h,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.network(
                          // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                          widget.vets.image.toString(),
                          width: 54.w,
                          height: 54.h,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "Dr. Naegha Blak",
                          widget.vets.name.toString(),
                          style: vetBookVetName,
                        ),
                        Text(
                          // "Cat Specialist",
                          widget.vets.degree.toString(),
                          style: vetBookVetJob,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Place & Time",
                    style: vetBookInputLabel,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingScreen(
                                  vets: widget.vets,
                                )),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: vetBookEdit,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w),
                width: 324.w,
                height: 74.h,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "In Person: ",
                          style: vetBookLabelPrimary,
                        ),
                        SizedBox(
                          width: 230,
                          child: Text(
                            // "Margahayu Raya",
                            // widget.timePlace["place"].toString(),
                            widget.vets.address.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: vetBookPlace,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          // "Selasa, 20 Agustus | (12:00-13:00)",
                          formatTime,
                          style: vetBookLabelPrimary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Personal Information",
                    style: vetBookInputLabel,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const VetsBookingThreeScreen()),
                      // );
                    },
                    child: Text(
                      "Edit",
                      style: vetBookEdit,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
                width: 324.w,
                height: 235.h,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "Muhammad Favian Jiwani",
                      widget.address["name"].toString(),
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Email:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "mfavianj@gmail.com",
                      widget.address["email"].toString(),
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Phone:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "+6282154785548",
                      '+62${widget.address["phone"]}',
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Visibility(
                      visible: widget.address["experience"] != '',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Experience:",
                            style: vetBookDetLabel,
                          ),
                          Text(
                            // "+3 years",
                            widget.address["experience"] == '1' ? '<1 Years' : '>1 Years',
                            style: vetBookDetValue,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pet Information",
                    style: vetBookInputLabel,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const VetsBookingThreeScreen()),
                      // );
                    },
                    child: Text(
                      "Edit",
                      style: vetBookEdit,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
                width: 324.w,
                height: 320.h,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "Mochi",
                      widget.pet.name.toString(),
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Category:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "Cat",
                      widget.pet.category.toString(),
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Visibility(
                      visible: widget.appointment['yearsTogether'] != '',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Years Together:",
                            style: vetBookDetLabel,
                          ),
                          Text(
                            // "+3 years",
                            widget.appointment['yearsTogether'] == '1' ? '<1 Years' : '>1 Years',
                            style: vetBookDetValue,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Possible Problem:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "Already Dead, Sorry",
                      widget.appointment["possibleProblem"].toString().replaceAll('[', '').replaceAll(']', ''),
                      style: vetBookDetValue,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Detail:",
                      style: vetBookDetLabel,
                    ),
                    Text(
                      // "My cat got flu, maybe because some infectionnnnnnnnnnnnnnnnnnnnnnnnnn",
                      widget.appointment["detail"].toString(),
                      style: vetBookDetValue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 110.h,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
        width: 1.sw,
        height: 72.h,
        decoration: BoxDecoration(color: whitish, boxShadow: [
          buildSecondaryBoxShadow(),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: SizedBox(
            width: 324.w,
            height: 54.h,
            child: ElevatedButton(
              onPressed: () async {
                int totalPayment = 80000;
                String? sellerId = widget.vets.id;
                String petId = widget.pet.id == ''
                    ? await ref.read(petControllerProvider.notifier).add(usersId: widget.usersId, pet: widget.pet)
                    : widget.pet.id.toString();

                final items = HistoryHealth(
                  id: petId,
                  petId: petId,
                  problem: widget.appointment["possibleProblem"],
                  desc: widget.appointment["detail"],
                  time: DateTime.now().millisecondsSinceEpoch.toString(),
                ).toJson();

                final order = Order(
                  createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  items: [items],
                  customerId: widget.usersId,
                  sellerId: sellerId,
                  itemsCategory: 'Appointment',
                  methodPayment: '',
                  statusPayment: '',
                  tokenPayment: '',
                  totalPayment: totalPayment,
                );

                await ref.read(orderControllerProvider.notifier).patientIncrement(widget.vets.id.toString());
                await ref.read(orderControllerProvider.notifier).add(order: order, usersId: widget.usersId);
                await ref.read(petControllerProvider.notifier).addHistoryHealth(id: petId, history: items);
                await ref.read(petControllerProvider.notifier).getData(widget.usersId);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Your appointment has been booked'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => const BotNavBarScreen()));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              child: Text(
                "Continue",
                style: vetBookOnBtnWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
