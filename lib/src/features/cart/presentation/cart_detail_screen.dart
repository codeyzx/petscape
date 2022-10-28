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
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/shared/theme.dart';

class CartDetailzScreen extends ConsumerStatefulWidget {
  final Users users;
  final List<Map<Product, int>> cart;
  const CartDetailzScreen({Key? key, required this.users, required this.cart}) : super(key: key);

  @override
  ConsumerState<CartDetailzScreen> createState() => _CartDetailzScreenState();
}

class _CartDetailzScreenState extends ConsumerState<CartDetailzScreen> {
  final _addressController = TextEditingController();
  MidtransSDK? _midtrans;

  Future<void> addFirestore(
      {required List<Map<String, int>> items,
      required Order order,
      required String usersId,
      required String orderId,
      required List<Product> product}) async {
    final orders = order.copyWith(orderId: orderId);
    await ref.read(orderControllerProvider.notifier).buy(items);
    await ref.read(orderControllerProvider.notifier).add(order: orders, usersId: usersId);

    await ref.read(cartControllerProvider.notifier).deleteListItem(usersId, product);
    await ref.read(cartControllerProvider.notifier).getData(usersId);

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
    final cart = widget.cart;
    final totalPrice = cart.fold(0, (total, item) => total + item.keys.first.price! * item.values.first);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                  "Order Details",
                  style: appBarTitle,
                ),
                SizedBox(
                  width: 29.w,
                  height: 29.h,
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
                SizedBox(height: 16.h),
                Text(
                  "Alamat",
                  style: treatBookLabel,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Stack(
                  children: [
                    Container(
                      width: 324.w,
                      height: 42.h,
                      decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                        buildPrimaryBoxShadow(),
                      ]),
                    ),
                    Center(
                      child: TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        style: homeSearchText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Alamat anda",
                            hintStyle: homeSearchHint,
                            contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: cart.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final product = cart[index].keys.first;
                    final qty = cart[index].values.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
                          width: 323.w,
                          height: 135.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: Image.network(
                                      // "https://i.pinimg.com/1200x/da/66/47/da6647f1615e67791fa6644d1a7663fa.jpg",
                                      product.image!,
                                      width: 64.w,
                                      height: 64.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 225.w,
                                          child: Text(
                                            // "Pharma Hemp Chicken Treats",
                                            product.name!,
                                            style: cartItemName,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Text(
                                        "$qty barang",
                                        style: cartItemTotal,
                                      ),
                                      Text(
                                        // "Rp36.000",
                                        NumberFormat.currency(
                                          locale: "id",
                                          symbol: "Rp",
                                          decimalDigits: 0,
                                        ).format(product.price! * qty),
                                        style: cartItemPrice,
                                      ),
                                    ],
                                  ),
                                ],
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
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: cartItemTotal,
                                  ),
                                  Text(
                                    // "Rp180.000",
                                    NumberFormat.currency(
                                      locale: "id",
                                      symbol: "Rp",
                                      decimalDigits: 0,
                                    ).format(product.price! * qty),
                                    style: cartItemPrice,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
          width: 1.sw,
          height: 80.h,
          decoration: BoxDecoration(color: whitish, boxShadow: [
            buildSecondaryBoxShadow(),
          ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Tagihan",
                    style: cartItemTotal,
                  ),
                  Text(
                    // "Rp300.000",
                    NumberFormat.currency(
                      locale: "id",
                      symbol: "Rp",
                      decimalDigits: 0,
                    ).format(totalPrice),
                    style: cartItemTotalPrice,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: SizedBox(
                  width: 203.w,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
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
                        final product = cart.map((e) => e.keys.first).toList();
                        final List<Map<String, int>> items = [];
                        for (final item in cart) {
                          items.add({
                            item.keys.first.id!: item.values.first,
                          });
                        }

                        final order = Order(
                          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                          items: items,
                          customerId: widget.users.uid,
                          sellerId: cart.first.keys.first.id!,
                          itemsCategory: 'Barang',
                          methodPayment: '',
                          statusPayment: '',
                          tokenPayment: '',
                          totalPayment: totalPrice,
                        );

                        // await ref.read(orderControllerProvider.notifier).buy(items);
                        // await ref.read(orderControllerProvider.notifier).add(order: order, usersId: widget.usersId);

                        // await ref.read(cartControllerProvider.notifier).deleteListItem(widget.usersId, product);
                        // await ref.read(cartControllerProvider.notifier).getData(widget.usersId);

                        // if (!mounted) return;
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const BotNavBarScreen(),
                        //     ));

                        String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                        String random = List.generate(15, (index) => chars[Random().nextInt(chars.length)]).join();

                        List<Map<String, dynamic>> itemsList = [];
                        for (final item in cart) {
                          itemsList.add({
                            'id': item.keys.first.id,
                            'name': item.keys.first.name,
                            'price': item.keys.first.price,
                            'quantity': item.values.first,
                          });
                        }

                        // final body = {
                        //   "order_id": "order-id-$random",
                        //   "customers": {"email": "${widget.users.email}", "username": "${widget.users.name}"},
                        //   "url": "https://mazipan.space/cara-fetch-api-di-nodejs",
                        //   "items": [
                        //     {"quantity": 2, "id": "1", "price": 2000, "name": "Es Teh"},
                        //     {"quantity": 3, "id": "2", "price": 8000, "name": "Nasi Goreng"}
                        //   ]
                        // };
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
                                items: items,
                                order: order,
                                usersId: widget.users.uid.toString(),
                                product: product);
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    child: Text(
                      "Proses Pembayaran",
                      style: vetBookOnBtnWhite,
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
