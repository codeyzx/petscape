import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
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
                "Detail Order",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              width: 324.w,
              height: 46.h,
              decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                buildPrimaryBoxShadow(),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Status Transaksi",
                    style: orderStatusLabel,
                  ),
                  widget.order.statusPayment == 'settlement' || widget.order.statusPayment == 'success'
                      ? Container(
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
                        )
                      : widget.order.statusPayment == 'pending'
                          ? Container(
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
                            )
                          : Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: failed,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Failed",
                                  style: orderItemStatusFailed,
                                ),
                              ),
                            ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
              width: 324.w,
              height: 96.h,
              decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                buildPrimaryBoxShadow(),
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transfer Ke",
                    style: orderStatusLabel,
                  ),
                  Text(
                    "${widget.order.methodPayment?.toUpperCase()} - ${widget.order.tokenPayment}",
                    style: orderBankAccount,
                  ),
                  Text(
                    "Waktu Pembelian: ${DateFormat("dd MMMM yyyy, HH:mm").format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.order.createdAt!)!))}",
                    style: orderPaymentDeadline,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
              width: 323.w,
              decoration: BoxDecoration(
                color: whitish,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  buildPrimaryBoxShadow(),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail ${widget.order.itemsCategory}",
                    style: orderStatusLabel,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.builder(
                    itemCount: widget.order.items!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = widget.order.items![index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.network(
                              "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                              width: 64.w,
                              height: 64.h,
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
                                "Dog Care - Showering",
                                style: orderStatusLabel,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "1 barang",
                                style: orderLocation,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Rp56.000",
                                style: orderPriceSmall,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    width: 301.w,
                    height: 1.h,
                    color: gray,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Harga",
                        style: orderTotalTxt,
                      ),
                      Text(
                        "Rp56.000",
                        style: orderStatusLabel,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
              width: 323.w,
              decoration: BoxDecoration(
                color: whitish,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  buildPrimaryBoxShadow(),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Info pengiriman",
                    style: orderStatusLabel,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Jalan Kliningan No.6 Buah Batu, Bandung, Indonesia",
                    style: orderLocation,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
