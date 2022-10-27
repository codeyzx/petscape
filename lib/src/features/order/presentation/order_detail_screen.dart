import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/shared/theme.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Text(
                "Your Order",
                style: orderTitle,
              ),
              SizedBox(
                height: 16.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Rp300.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "6 barang",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: pending,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Pending",
                                style: orderItemStatusPending,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "jnCnbwou8BU7bn4JUBWn03",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "12 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "240.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "3 barang",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: success,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Success",
                                style: orderItemStatusSuccess,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "sjba9VBjbdjvb0o98uvbdhb1",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "11 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "240.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "1 Appointment",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: pending,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Pending",
                                style: orderItemStatusPending,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "sjba9VBjbdjvb0o98uvbdhb1",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "10 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "240.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "1 Appointment",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: success,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Success",
                                style: orderItemStatusSuccess,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "sjba9VBjbdjvb0o98uvbdhb1",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "10 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "240.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "1 Service",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: pending,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Pending",
                                style: orderItemStatusPending,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "sjba9VBjbdjvb0o98uvbdhb1",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "10 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  width: 324.w,
                  height: 103.h,
                  decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                    buildPrimaryBoxShadow(),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "240.000",
                                style: orderItemPrice,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 1.w,
                                height: 15.h,
                                color: black.withOpacity(0.60),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "1 Service",
                                style: orderItemTotal,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: pending,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                "Success",
                                style: orderItemStatusSuccess,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "sjba9VBjbdjvb0o98uvbdhb1",
                        style: orderItemID,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "10 Okt",
                        style: orderItemDate,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
