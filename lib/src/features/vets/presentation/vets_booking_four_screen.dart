import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
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
  final Users users;
  final Vets vets;
  final Pet pet;

  const VetsBookingFourScreen(
      {Key? key,
      required this.appointment,
      required this.address,
      required this.timePlace,
      required this.users,
      required this.vets,
      required this.pet})
      : super(key: key);

  @override
  ConsumerState<VetsBookingFourScreen> createState() => _VetsBookingFourScreenState();
}

class _VetsBookingFourScreenState extends ConsumerState<VetsBookingFourScreen> {
  MidtransSDK? _midtrans;

  Future<void> addFirestore({
    required Order order,
    required String usersId,
    required String orderId,
    required String petId,
    required Map<String, dynamic> history,
  }) async {
    final orders = order.copyWith(orderId: orderId);
    await ref.read(orderControllerProvider.notifier).patientIncrement(widget.vets.id.toString());
    await ref.read(orderControllerProvider.notifier).add(order: orders, usersId: usersId);
    await ref.read(petControllerProvider.notifier).addHistoryHealth(id: petId, history: history);
    await ref.read(petControllerProvider.notifier).getData(widget.users.uid.toString());

    if (!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BotNavBarScreen(),
        ));
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

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
                          widget.vets.name.toString(),
                          style: vetBookVetName,
                        ),
                        Text(
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                _midtrans = await MidtransSDK.init(
                  config: MidtransConfig(
                    clientKey: "SB-Mid-client-Jf7_deynf20wZtJq",
                    merchantBaseUrl: "https://marcha-api-production.up.railway.app/notification_handler/",
                  ),
                );

                _midtrans?.setUIKitCustomSetting(
                  skipCustomerDetailsPages: true,
                  showPaymentStatus: true,
                );

                int totalPayment = widget.vets.price!;
                String? sellerId = widget.vets.id;
                String petId = widget.pet.id == ''
                    ? await ref
                        .read(petControllerProvider.notifier)
                        .add(usersId: widget.users.uid.toString(), pet: widget.pet)
                    : widget.pet.id.toString();

                final items = HistoryHealth(
                  id: petId,
                  petId: petId,
                  problem: widget.appointment["possibleProblem"],
                  desc: widget.appointment["detail"],
                  time: DateTime.now().millisecondsSinceEpoch.toString(),
                  vets: widget.vets.toJson(),
                ).toJson();

                final order = Order(
                  createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  items: [items],
                  customerId: widget.users.uid,
                  sellerId: sellerId,
                  itemsCategory: 'Appointment',
                  methodPayment: '',
                  statusPayment: '',
                  tokenPayment: '',
                  totalPayment: totalPayment,
                );

                String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                String random = List.generate(15, (index) => chars[Random().nextInt(chars.length)]).join();

                List<Map<String, dynamic>> itemsList = [
                  {
                    'id': widget.vets.id,
                    'name': widget.vets.name,
                    'price': widget.vets.price,
                    'quantity': 1,
                  }
                ];

                Map<String, dynamic> body = {
                  "order_id": random,
                  "customers": {
                    "email": "${widget.users.email}",
                    "username": "${widget.users.name}",
                  },
                  "url": "",
                  "items": itemsList,
                };

                final token = await ref.read(cartControllerProvider.notifier).getToken(body);
                await _midtrans?.startPaymentUiFlow(
                  token: token,
                );
                _midtrans!.setTransactionFinishedCallback((result) async {
                  if (!result.isTransactionCanceled) {
                    await addFirestore(
                      orderId: result.orderId.toString(),
                      order: order,
                      usersId: widget.users.uid.toString(),
                      petId: petId,
                      history: items,
                    );
                  }
                });
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
