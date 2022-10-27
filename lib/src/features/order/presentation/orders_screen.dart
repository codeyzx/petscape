import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/order/presentation/order_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const routeName = '/order';
  const OrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderScreenState();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Your Order",
                  style: appBarTitle,
                ),
              ),
              ListView.builder(
                itemCount: order.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order[index])));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        width: 324.w,
                        height: 100.h,
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 8.w, right: 12.w),
                        decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(order[index].totalPayment),

                                      // vets[index].name.toString(),
                                      style: homeDoctorName,
                                    ),
                                    Text(
                                      ' | ${order[index].items!.length} ${order[index].itemsCategory}',
                                      // vets[index].location.toString(),
                                      style: homeDoctorAddress.copyWith(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order[index].id!,
                                      // vets[index].name.toString(),
                                      style: homeDoctorName.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(int.tryParse(order[index].createdAt!)!)),
                                      // vets[index].location.toString(),
                                      style: homeDoctorAddress,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Center(
                                child: Text(
                                  order[index].statusPayment == '' ? 'No Status' : order[index].statusPayment!,
                                  style: GoogleFonts.poppins(
                                    color: whitish,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
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
