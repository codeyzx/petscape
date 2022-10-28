import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/order/presentation/order_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const routeName = 'order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final usersId = ref.read(authControllerProvider).uid;
    await ref.read(orderControllerProvider.notifier).getData(usersId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderControllerProvider);

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
              ListView.builder(
                itemCount: order.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                    order: order[index],
                                  )),
                        );
                      },
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
                                      // "Rp300.000",
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp',
                                        decimalDigits: 0,
                                      ).format(order[index].totalPayment),
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
                                      "${order[index].items?.length} ${order[index].itemsCategory}",
                                      style: orderItemTotal,
                                    ),
                                  ],
                                ),
                                order[index].statusPayment == 'settlement' || order[index].statusPayment == 'success'
                                    ? Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: success,
                                          borderRadius: BorderRadius.circular(6.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            // "Success",
                                            '${order[index].statusPayment == 'settlement' ? 'Success' : order[index].statusPayment}',
                                            style: orderItemStatusSuccess,
                                          ),
                                        ),
                                      )
                                    : order[index].statusPayment == 'pending'
                                        ? Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: pending,
                                              borderRadius: BorderRadius.circular(6.r),
                                            ),
                                            child: Center(
                                              child: Text(
                                                // "Pending",
                                                '${order[index].statusPayment}',
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
                                                // "Pending",
                                                '${order[index].statusPayment}',
                                                style: orderItemStatusFailed,
                                              ),
                                            ),
                                          ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              // "jnCnbwou8BU7bn4JUBWn03",
                              '${order[index].orderId}',
                              style: orderItemID,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              // "12 Okt",
                              DateFormat('dd MMM').format(
                                  DateTime.fromMillisecondsSinceEpoch(int.tryParse(order[index].createdAt.toString())!)),
                              style: orderItemDate,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
