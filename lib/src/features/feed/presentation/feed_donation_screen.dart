import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
import 'package:petscape/src/features/feed/domain/feed.dart';
import 'package:petscape/src/features/feed/presentation/feed_controller.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/shared/theme.dart';

class FeedDonationScreen extends ConsumerStatefulWidget {
  final Feed feed;
  final Users users;
  const FeedDonationScreen({Key? key, required this.feed, required this.users}) : super(key: key);

  @override
  ConsumerState<FeedDonationScreen> createState() => _FeedDonationScreenState();
}

class _FeedDonationScreenState extends ConsumerState<FeedDonationScreen> {
  MidtransSDK? _midtrans;

  Future<void> addFirestore({
    required Order order,
    required String usersId,
    required String orderId,
    required String feedId,
    required int amount,
  }) async {
    final orders = order.copyWith(orderId: orderId);

    await ref.read(feedControllerProvider.notifier).increment(id: feedId, value: amount);
    await ref.read(orderControllerProvider.notifier).add(order: orders, usersId: usersId);
    await ref.read(orderControllerProvider.notifier).getData(usersId.toString());

    if (!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BotNavBarScreen(),
        ));
  }

  bool isEnabled = true;
  final textController = TextEditingController();
  List<Map<int, bool>> isSelected = [
    {10000: false},
    {20000: false},
    {50000: false},
    {100000: false},
  ];

  int amount = 0;

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                "Donasi",
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
                height: 24.h,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: 328.w,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.feed.photo.toString(),
                      width: 80.w,
                      height: 56.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                        child: Text(
                      widget.feed.title.toString(),
                      style: feedCaption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                "Pilih Jumlah",
                style: feedDonationLabel,
              ),
              SizedBox(
                height: 10.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 54.h, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w, crossAxisCount: 2),
                itemCount: isSelected.length,
                itemBuilder: (context, index) => isSelected[index].values.first
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            for (var element in isSelected) {
                              amount = 0;
                              isEnabled = true;
                              element.update(element.keys.first, (value) => false);
                              textController.text = '';
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: primary,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 159.w,
                          height: 54.h,
                          decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                          child: Center(
                              child: Text(
                            // "Rp 10.000",
                            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                .format(isSelected[index].keys.first),
                            style: feedDonationMoneyItem.copyWith(color: whitish),
                          )),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            for (var element in isSelected) {
                              if (element.keys.first == isSelected[index].keys.first) {
                                element.update(element.keys.first, (value) => true);
                                amount = isSelected[index].keys.first;
                                isEnabled = false;
                                textController.text = '';
                              } else {
                                element.update(element.keys.first, (value) => false);
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 159.w,
                          height: 54.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                          child: Center(
                              child: Text(
                            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                .format(isSelected[index].keys.first),
                            style: feedDonationMoneyItem,
                          )),
                        ),
                      ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 132.w,
                    height: 1.h,
                    color: black.withOpacity(0.15),
                  ),
                  Text(
                    "atau",
                    style: homeSearchHint,
                  ),
                  Container(
                    width: 132.w,
                    height: 1.h,
                    color: black.withOpacity(0.15),
                  ),
                ],
              ),
              SizedBox(
                height: 11.h,
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 328.w,
                    height: 52.h,
                    decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                      buildPrimaryBoxShadow(),
                    ]),
                  ),
                  Center(
                    child: TextFormField(
                      enabled: isEnabled,
                      controller: textController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLines: 3,
                      style: homeSearchText,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Jumlah",
                          hintStyle: homeSearchHint,
                          contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                    ),
                  ),
                ],
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
                if (isEnabled) {
                  if (textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Harap isi jumlah donasi'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    amount = int.parse(textController.text);
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

                    String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                    String random = List.generate(15, (index) => chars[Random().nextInt(chars.length)]).join();

                    List<Map<String, dynamic>> itemsList = [
                      {
                        'id': Random().nextInt(100).toString(),
                        'name':
                            'Donasi sejumlah ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(amount)}',
                        'price': amount,
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

                    final order = Order(
                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                      items: itemsList,
                      customerId: widget.users.uid.toString(),
                      sellerId: widget.feed.id,
                      itemsCategory: 'Donasi',
                      methodPayment: '',
                      statusPayment: '',
                      tokenPayment: '',
                      totalPayment: amount,
                    );

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
                            feedId: widget.feed.id.toString(),
                            amount: amount);
                      }
                    });
                  }
                } else {
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

                  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                  String random = List.generate(15, (index) => chars[Random().nextInt(chars.length)]).join();

                  List<Map<String, dynamic>> itemsList = [
                    {
                      'id': Random().nextInt(100).toString(),
                      'name':
                          'Donasi sejumlah ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(amount)}',
                      'price': amount,
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

                  final order = Order(
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                    items: itemsList,
                    customerId: widget.users.uid.toString(),
                    sellerId: widget.feed.id,
                    itemsCategory: 'Donasi',
                    methodPayment: '',
                    statusPayment: '',
                    tokenPayment: '',
                    totalPayment: amount,
                  );

                  Logger().e(order);

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
                          feedId: widget.feed.id.toString(),
                          amount: amount);
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              child: Text(
                "Konfirmasi & Bayar",
                style: vetBookOnBtnWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
