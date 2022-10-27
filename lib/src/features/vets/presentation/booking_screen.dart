import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/vets_booking_two_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Vets? vets;
  final Product? product;
  final String? usersId;
  const BookingScreen({Key? key, this.vets, this.product, this.usersId}) : super(key: key);

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  List<Map<String, bool>> placeOptions = [
    {'In Person': true},
    {'Online Meet': false},
  ];

  // List<Map<DateTime, bool>> generateTime() {
  //   // final date = DateTime.now();
  //   // final hour = date.hour;
  //   // final minute = date.minute;
  //   // final second = date.second;
  //   // final startTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} $hour:$minute:$second';
  //   // final endTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 12:00:00';

  //   // final List<String> timeSlots = [];
  //   // final start = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startTime);
  //   // final end = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endTime);
  //   // final difference = end.difference(start).inHours;

  //   // for (var i = 0; i <= difference; i++) {
  //   //   timeSlots.add(DateFormat('HH:mm').format(start.add(Duration(hours: i))));
  //   // }
  //   // return timeSlots;
  //   final startTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 10:00:00';
  //   final endTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 15:00:00';

  //   final List<String> timeSlots = [];
  //   final start = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startTime);
  //   final end = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endTime);
  //   final difference = end.difference(start).inHours;

  //   for (var i = 0; i <= difference; i++) {
  //     timeSlots.add(DateFormat('HH:mm').format(start.add(Duration(hours: i))));
  //   }
  //   // return timeSlots;
  //   final List<Map<DateTime, bool>> timeSlotsMap = [];
  //   for (var i = 0; i < timeSlots.length; i++) {
  //     if (i == 0) {
  //       timeSlotsMap.add({
  //         DateFormat('yyyy-MM-dd HH:mm:ss').parse('${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00'):
  //             true
  //       });
  //     } else {
  //       timeSlotsMap.add({
  //         DateFormat('yyyy-MM-dd HH:mm:ss').parse('${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00'):
  //             false
  //       });
  //     }
  //   }
  //   return timeSlotsMap;
  // }

  List<Map<String, bool>> resetTime() {
    final startTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 10:00:00';
    final endTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 15:00:00';

    final List<String> timeSlots = [];
    final start = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startTime);
    final end = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endTime);
    final difference = end.difference(start).inHours;

    for (var i = 0; i <= difference; i++) {
      timeSlots.add(DateFormat('HH:mm').format(start.add(Duration(hours: i))));
    }
    // return timeSlots;
    final List<Map<String, bool>> timeSlotsMap = [];
    for (var i = 0; i < timeSlots.length; i++) {
      if (i == 0) {
        timeSlotsMap.add({'${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00': true});
        time = timeSlots[i];
      } else {
        timeSlotsMap.add({'${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00': false});
      }
    }
    return timeSlotsMap;
  }

  List<Map<String, bool>> generateTime() {
    //* DEBUG
    // final startTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00';
    // final endTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 23:00:00';

    //* PRODUCTION
    final startTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 10:00:00';
    final endTime = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 15:00:00';

    final List<String> timeSlots = [];
    final start = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startTime);
    final end = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endTime);
    final difference = end.difference(start).inHours;

    for (var i = 0; i <= difference; i++) {
      timeSlots.add(DateFormat('HH:mm').format(start.add(Duration(hours: i))));
    }
    final List<Map<String, bool>> timeSlotsMap = [];
    for (var i = 0; i < timeSlots.length; i++) {
      final date = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00';
      // final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse('2022-10-26 12:23:43.677538');
      final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateTime.now().toString());
      final minute = dateTimeNow.minute < 59 ? '00' : dateTimeNow.minute;

      var dateTimeNowRounded = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${dateTimeNow.hour + 1}:$minute:00';

      // if (dateTimeNow.compareTo(start) > 0) {
      //   Logger().e('masuk');
      //   if (dateTimeNow.hour < 10) {
      //     final temp = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeNowRounded);
      //     temp.add(const Duration(hours: 1));
      //     dateTimeNowRounded = DateFormat('yyyy-MM-dd HH:mm:ss').format(temp);
      //   } else {
      //     dateTimeNowRounded = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${dateTimeNow.hour}:$minute:00';
      //   }
      // } else {
      //   Logger().e('ga masuk');
      //   dateTimeNowRounded = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${dateTimeNow.hour}:$minute:00';
      // }

      if (dateTimeNow.compareTo(start) > 0) {
        if (dateTimeNow.hour < 10) {
          final temp = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeNowRounded);
          temp.add(const Duration(hours: 1));
          dateTimeNowRounded = DateFormat('yyyy-MM-dd HH:mm:ss').format(temp);
        } else {
          dateTimeNowRounded = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${dateTimeNow.hour + 1}:$minute:00';
        }
      } else {
        dateTimeNowRounded = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${start.hour}:00:00';
      }

      final compare = DateTime.parse(date).compareTo(DateTime.parse(dateTimeNowRounded));

      if (compare == 0) {
        timeSlotsMap.add({'${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00': true});
        time = timeSlots[i];
      } else {
        timeSlotsMap.add({'${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${timeSlots[i]}:00': false});
      }
    }
    return timeSlotsMap;
  }

  List<Map<String, bool>> generateDate() {
    final List<String> dateSlots = [];
    final date = DateTime.now();
    final day = date.day;
    final month = date.month;
    final year = date.year;
    final startTime = '$year-$month-$day';
    final endTime = '$year-$month-${day + 7}';

    final start = DateFormat('yyyy-MM-dd').parse(startTime);
    final end = DateFormat('yyyy-MM-dd').parse(endTime);
    final difference = end.difference(start).inDays;

    for (var i = 0; i < difference; i++) {
      dateSlots.add(DateFormat('yyyy-MM-dd').format(start.add(Duration(days: i))));
    }
    final List<Map<String, bool>> dateSlotsMap = [];
    for (var i = 0; i < dateSlots.length; i++) {
      if (i == 0) {
        dateSlotsMap.add({dateSlots[i]: true});
      } else {
        dateSlotsMap.add({dateSlots[i]: false});
      }
    }
    return dateSlotsMap;
  }

  List dateOptions = [];
  List timeOptions = [];
  Product? product;
  String dateFilter = DateTime.now().toString();

  // List<String> generateDate() {
  //   final startDate = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00';
  //   final endDate = '${DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 7)))} 23:59:59';

  //   final List<String> dateSlots = [];
  //   final start = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startDate);
  //   final end = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endDate);
  //   final difference = end.difference(start).inDays;

  //   for (var i = 0; i < difference; i++) {
  //     dateSlots.add(DateFormat('yyyy-MM-dd').format(start.add(Duration(days: i))));
  //   }
  //   return dateSlots;
  // }

  // List<Map<DateTime, bool>> generateDate() = [];

  // List<Map<DateTime, bool>> generateDate() = [];

  // List<Map<DateTime, bool>> timeOptions = [
  //   {DateTime.now(): true},
  //   {DateTime.now().add(const Duration(hours: 1)): false},
  //   {DateTime.now().add(const Duration(hours: 2)): false},
  //   {DateTime.now().add(const Duration(hours: 3)): false},
  //   {DateTime.now().add(const Duration(hours: 4)): false},
  //   {DateTime.now().add(const Duration(hours: 5)): false},
  //   {DateTime.now().add(const Duration(hours: 6)): false},
  //   {DateTime.now().add(const Duration(hours: 7)): false},
  //   {DateTime.now().add(const Duration(hours: 8)): false},
  //   {DateTime.now().add(const Duration(hours: 9)): false},
  //   {DateTime.now().add(const Duration(hours: 10)): false},
  //   {DateTime.now().add(const Duration(hours: 11)): false},
  //   {DateTime.now().add(const Duration(hours: 12)): false},
  // ];

  String place = 'In Person';
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String time = '';

  @override
  void initState() {
    super.initState();
    dateOptions = generateDate();
    timeOptions = generateTime();
    if (widget.product != null) {
      product = widget.product;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                // "Booking Appointment",
                widget.product != null ? "Buat Pesanan" : "Booking Appointment",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product == null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Select Time & Place",
                        style: vetBookTitle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Step 1/4",
                        style: vetBookPart,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Place",
                        style: vetBookSubTitle,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        // children: [
                        //   ClipRRect(
                        //     borderRadius: BorderRadius.circular(4.r),
                        //     child: SizedBox(
                        //       width: 123.w,
                        //       height: 40.h,
                        //       child: ElevatedButton(
                        //         onPressed: () {},
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: primary,
                        //         ),
                        //         child: Text(
                        //           "In Person",
                        //           style: vetBookWhiteOnButton,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   SizedBox(
                        //     width: 12.w,
                        //   ),
                        //   SizedBox(
                        //     width: 144.w,
                        //     height: 40.h,
                        //     child: ElevatedButton(
                        //       onPressed: () {},
                        //       style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                        //       child: Container(
                        //         width: 144.w,
                        //         height: 40.h,
                        //         decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                        //           buildPrimaryBoxShadow(),
                        //         ]),
                        //         child: Center(
                        //           child: Text(
                        //             "Online Meet",
                        //             style: productCategoryBlack,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ],
                        children: placeOptions.map((e) {
                          return e.values.first
                              ? Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.r),
                                      child: SizedBox(
                                        width: 144.w,
                                        height: 40.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              for (var element in placeOptions) {
                                                if (element.keys.first == e.keys.first) {
                                                  element.update(element.keys.first, (value) => true);
                                                  place = e.keys.first;
                                                } else {
                                                  element.update(element.keys.first, (value) => false);
                                                }
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primary,
                                          ),
                                          child: Text(
                                            e.keys.first,
                                            style: vetBookWhiteOnButton,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: 144.w,
                                      height: 40.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            for (var element in placeOptions) {
                                              if (element.keys.first == e.keys.first) {
                                                element.update(element.keys.first, (value) => true);
                                                place = e.keys.first;
                                              } else {
                                                element.update(element.keys.first, (value) => false);
                                              }
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                                        child: Container(
                                          width: 144.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              color: whitish,
                                              borderRadius: BorderRadius.circular(4.r),
                                              boxShadow: [
                                                buildPrimaryBoxShadow(),
                                              ]),
                                          child: Center(
                                            child: Text(
                                              e.keys.first,
                                              style: productCategoryBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                  ],
                                );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        "Time",
                        style: vetBookSubTitle,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        width: 324.w,
                        height: 96.h,
                        decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.network(
                                // "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                                product!.image.toString(),
                                width: 72.w,
                                height: 72.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Dog Care - Suntik Mati",
                                  product!.name.toString(),
                                  style: treatBookPetName,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      // "Petcuttie",
                                      product!.seller.toString(),
                                      style: treatBookPetLoc,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Container(
                                      width: 1.w,
                                      height: 15.h,
                                      color: black.withOpacity(0.60),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      // "Bandung",
                                      product!.location.toString(),
                                      style: treatBookPetLoc,
                                    ),
                                  ],
                                ),
                                Text(
                                  // "Rp56.000",
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0,
                                  ).format(product!.price),
                                  style: treatBookPrice,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Detail Lokasi",
                        style: treatBookLabel,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: whitish, boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                        child: Text(
                          // "Jl. Kliningan No.6 RT 02 RW 05, Bandung, Jawa Barat, Indonesia",
                          product!.location.toString(),
                          style: treatBookLoc,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Waktu",
                        style: treatBookLabel,
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: 6.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.w),
              child: Row(
                // children: [
                //   SizedBox(
                //     width: 18.w,
                //   ),
                //   SizedBox(
                //     width: 60.w,
                //     height: 80.h,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                //       child: Container(
                //         width: 60.w,
                //         height: 80.h,
                //         decoration: BoxDecoration(
                //           color: primary,
                //           borderRadius: BorderRadius.circular(6.r),
                //           boxShadow: [buildPrimaryBoxShadow()],
                //         ),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "Sel",
                //               style: vetBookDayOnPrimary,
                //             ),
                //             SizedBox(
                //               height: 6.h,
                //             ),
                //             Text(
                //               "20",
                //               style: vetBookDateOnPrimary,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(
                //     height: 100.h,
                //     child: ListView.builder(
                //         itemCount: 5,
                //         physics: const ScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         itemBuilder: (BuildContext context, int index) {
                //           return Row(
                //             children: [
                //               SizedBox(
                //                 width: 6.w,
                //               ),
                //               SizedBox(
                //                 width: 60.w,
                //                 height: 80.h,
                //                 child: ElevatedButton(
                //                   onPressed: () {},
                //                   style:
                //                       ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                //                   child: Container(
                //                     width: 60.w,
                //                     height: 80.h,
                //                     decoration: BoxDecoration(
                //                       color: whitish,
                //                       borderRadius: BorderRadius.circular(6.r),
                //                       boxShadow: [buildPrimaryBoxShadow()],
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment: CrossAxisAlignment.center,
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Text(
                //                           "Rab",
                //                           style: vetBookDayOnWhite,
                //                         ),
                //                         SizedBox(
                //                           height: 6.h,
                //                         ),
                //                         Text(
                //                           "21",
                //                           style: vetBookDateOnWhite,
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         }),
                //   ),
                //   SizedBox(
                //     width: 18.w,
                //   ),

                // ],
                children: dateOptions.map((e) {
                  return e.values.first
                      ? Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: SizedBox(
                            width: 60.w,
                            height: 80.h,
                            child: ElevatedButton(
                              onPressed: () {
                                // setState(() {
                                //   for (var element in dateOptions) {
                                //     if (element.keys.first == e.keys.first) {
                                //       element.update(element.keys.first, (value) => true);
                                //       date = e.keys.first;
                                //     } else {
                                //       element.update(element.keys.first, (value) => false);
                                //     }
                                //   }
                                // });
                              },
                              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                              child: Container(
                                width: 60.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(6.r),
                                  boxShadow: [buildPrimaryBoxShadow()],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // "Sel",
                                      // format date time to day
                                      DateFormat('EEE').format(DateTime.parse(e.keys.first)),
                                      style: vetBookDayOnPrimary,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      // "20",
                                      // format date time to date
                                      DateFormat('d').format(DateTime.parse(e.keys.first)),
                                      style: vetBookDateOnPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: SizedBox(
                            width: 60.w,
                            height: 80.h,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  for (var element in dateOptions) {
                                    if (element.keys.first == e.keys.first) {
                                      element.update(element.keys.first, (value) => true);
                                      date = e.keys.first;
                                      timeOptions = resetTime();

                                      final filter = '${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00';
                                      final filterDate = DateTime.parse(filter);
                                      dateFilter = filterDate.toString();
                                    } else {
                                      element.update(element.keys.first, (value) => false);
                                    }
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                              child: Container(
                                width: 60.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  color: whitish,
                                  borderRadius: BorderRadius.circular(6.r),
                                  boxShadow: [buildPrimaryBoxShadow()],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // "Rab",
                                      // format date time to day
                                      DateFormat('EEE').format(DateTime.parse(e.keys.first)),
                                      style: vetBookDayOnWhite,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      // "21",
                                      // format date time to date
                                      DateFormat('d').format(DateTime.parse(e.keys.first)),
                                      style: vetBookDateOnWhite,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.w),
              child: Row(
                // children: [
                //   SizedBox(
                //     width: 18.w,
                //   ),
                //   // disabled
                //   SizedBox(
                //     width: 89.w,
                //     height: 40.h,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                //       child: Container(
                //         width: 89.w,
                //         height: 40.h,
                //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: gray, boxShadow: [
                //           buildPrimaryBoxShadow(),
                //         ]),
                //         child: Center(
                //           child: Text(
                //             "10:00",
                //             style: vetBookClockOnGray,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(
                //     width: 8.w,
                //   ),
                //   // enabled
                //   SizedBox(
                //     width: 89.w,
                //     height: 40.h,
                //     child: ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                //       child: Container(
                //         width: 89.w,
                //         height: 40.h,
                //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: primary, boxShadow: [
                //           buildPrimaryBoxShadow(),
                //         ]),
                //         child: Center(
                //           child: Text(
                //             "11:00",
                //             style: vetBookClockOnPrimary,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(
                //     height: 60.h,
                //     child: ListView.builder(
                //         itemCount: 5,
                //         physics: const ScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         itemBuilder: (BuildContext context, int index) {
                //           return Row(
                //             children: [
                //               SizedBox(
                //                 width: 8.w,
                //               ),
                //               //default
                //               SizedBox(
                //                 width: 89.w,
                //                 height: 40.h,
                //                 child: ElevatedButton(
                //                   onPressed: () {},
                //                   style:
                //                       ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                //                   child: Container(
                //                     width: 89.w,
                //                     height: 40.h,
                //                     decoration:
                //                         BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: whitish, boxShadow: [
                //                       buildPrimaryBoxShadow(),
                //                     ]),
                //                     child: Center(
                //                       child: Text(
                //                         "12:00",
                //                         style: vetBookClockOnWhite,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         }),
                //   ),
                //   SizedBox(
                //     width: 18.w,
                //   )
                // ],
                children: timeOptions.map((e) {
                  // final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse('2022-10-25 20:23:43.677538');
                  // final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateTime.now().toString());
                  // final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateTime.now().toString());
                  final dateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateFilter);
                  // Logger().e(dateTimeNow);
                  final compare = DateTime.parse(e.keys.first).compareTo(dateTimeNow);
                  return e.values.first
                      ? Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: SizedBox(
                            width: 89.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  for (var element in timeOptions) {
                                    if (element.keys.first == e.keys.first) {
                                      element.update(element.keys.first, (value) => true);
                                      time = DateFormat('HH:mm').format(DateTime.parse(e.keys.first));
                                    } else {
                                      element.update(element.keys.first, (value) => false);
                                    }
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                              child: Container(
                                width: 89.w,
                                height: 40.h,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: primary, boxShadow: [
                                  buildPrimaryBoxShadow(),
                                ]),
                                child: Center(
                                  child: Text(
                                    // "11:00",
                                    // format date time to time
                                    DateFormat('HH:mm').format(DateTime.parse(DateTime.parse(e.keys.first).toString())),
                                    style: vetBookClockOnPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : compare < 0
                          ? Padding(
                              padding: EdgeInsets.only(left: 18.w),
                              child: SizedBox(
                                width: 89.w,
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                                  child: Container(
                                    width: 89.w,
                                    height: 40.h,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: gray, boxShadow: [
                                      buildPrimaryBoxShadow(),
                                    ]),
                                    child: Center(
                                      child: Text(
                                        // "10:00",
                                        // format date time to time
                                        DateFormat('HH:mm').format(DateTime.parse(DateTime.parse(e.keys.first).toString())),
                                        style: vetBookClockOnGray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 18.w),
                              child: SizedBox(
                                width: 89.w,
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      for (var element in timeOptions) {
                                        if (element.keys.first == e.keys.first) {
                                          element.update(element.keys.first, (value) => true);
                                          time = DateFormat('HH:mm').format(DateTime.parse(e.keys.first));
                                        } else {
                                          element.update(element.keys.first, (value) => false);
                                        }
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                                  child: Container(
                                    width: 89.w,
                                    height: 40.h,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: whitish, boxShadow: [
                                      buildPrimaryBoxShadow(),
                                    ]),
                                    child: Center(
                                      child: Text(
                                        // "12:00",
                                        // format date time to time
                                        DateFormat('HH:mm').format(DateTime.parse(DateTime.parse(e.keys.first).toString())),
                                        style: vetBookClockOnWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: widget.product == null
          ? Container(
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
                    onPressed: () {
                      if (time != '') {
                        final timePlace = {
                          'place': place,
                          'date': date,
                          'time': time,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VetsBookingTwoScreen(
                                    vets: widget.vets!,
                                    timePlace: timePlace,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select time'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
              width: 1.sw,
              height: 72.h,
              decoration: BoxDecoration(color: whitish, boxShadow: [
                buildSecondaryBoxShadow(),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: SizedBox(
                  width: 324.w,
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      final items = {
                        'place': place,
                        'date': date,
                        'time': time,
                        'product': widget.product!.id,
                      };
                      final order = Order(
                        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                        items: [items],
                        customerId: widget.usersId,
                        sellerId: product!.id,
                        itemsCategory: 'Treatment',
                        methodPayment: '',
                        statusPayment: '',
                        tokenPayment: '',
                        totalPayment: product!.price,
                      );
                      final List<Map<String, int>> buyItem = [
                        {widget.product!.id!: 1}
                      ];

                      await ref.read(orderControllerProvider.notifier).buy(buyItem);
                      await ref.read(orderControllerProvider.notifier).add(order: order, usersId: widget.usersId.toString());

                      await ref.read(orderControllerProvider.notifier).getData(widget.usersId.toString());

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Your order has been successfully created'),
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
                      // "Proses Pembayaran - Rp56.000",
                      "Proses Pembayaran - Rp${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(product!.price)}",
                      style: vetBookOnBtnWhite,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
