import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/product/presentation/product_controller.dart';
import 'package:petscape/src/shared/theme.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final Order order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getListProduct();
  }

  Future<void> getListProduct() async {
    // Logger().e(widget.order.toJson());
    if (widget.order.itemsCategory == 'Barang') {
      List<String> docId = [];
      for (var i = 0; i < widget.order.items!.length; i++) {
        docId.add(widget.order.items![i].keys.first);
      }

      final product = await ref.read(productControllerProvider.notifier).getListData(docId);
      setState(() {
        products = product;
      });
    } else if (widget.order.itemsCategory == 'Treatment') {
      List<String> docId = [];
      for (var i = 0; i < widget.order.items!.length; i++) {
        docId.add(widget.order.items![i]['product']);
      }

      final product = await ref.read(productControllerProvider.notifier).getListData(docId);
      setState(() {
        products = product;
      });
    }
  }

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
              height: 50.h,
              decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                buildPrimaryBoxShadow(),
              ]),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tanggal Pembelian",
                    style: orderStatusLabel,
                  ),
                  Text(
                    DateFormat("dd MMMM yyyy")
                        .format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.order.createdAt!)!)),
                    style: orderBankAccount,
                  ),
                  // Text(
                  //   style: orderPaymentDeadline,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Visibility(
              visible: widget.order.statusPayment == 'settlement' || widget.order.statusPayment == 'success' ? false : true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
                    width: 324.w,
                    height: 80.h,
                    decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(6.r), boxShadow: [
                      buildPrimaryBoxShadow(),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Transfer Ke",
                          style: orderStatusLabel,
                        ),
                        Text(
                          "${widget.order.methodPayment?.toUpperCase()} - ${widget.order.tokenPayment}",
                          style: orderBankAccount,
                        ),
                        // Text(
                        //   "Waktu Pembelian: ${DateFormat("dd MMMM yyyy, HH:mm").format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(widget.order.createdAt!)!))}",
                        //   style: orderPaymentDeadline,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
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
                  // TODO: CHANGE DYNAMIC
                  widget.order.itemsCategory == 'Barang'
                      ? ListView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map orderItem = widget.order.items![index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: Image.network(
                                      // "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                                      products[index].image.toString(),
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
                                        // "Dog Care - Showering",
                                        products[index].name.toString(),
                                        style: orderStatusLabel,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        "${orderItem.values.first} barang",
                                        style: orderLocation,
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        // "Rp56.000",
                                        "Rp${products[index].price}",
                                        style: orderPriceSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : widget.order.itemsCategory == 'Treatmet'
                          ? ListView.builder(
                              itemCount: products.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Map orderItem = widget.order.items![index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6.r),
                                        child: Image.network(
                                          // "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                                          products[index].image.toString(),
                                          // orderItem
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
                                            // "Dog Care - Showering",
                                            products[index].name.toString(),
                                            style: orderStatusLabel,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            // "Rp56.000",
                                            "Rp${products[index].price}",
                                            style: orderPriceSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Map orderItem = widget.order.items?.first;
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // "Dog Care - Showering",
                                            // products[index].name.toString(),
                                            orderItem['name'],
                                            style: orderStatusLabel,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            // "Rp56.000",
                                            // "Rp${products[index].price}",
                                            NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'Rp',
                                              decimalDigits: 0,
                                            ).format(orderItem['price']),
                                            style: orderPriceSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                        // "Rp56.000",
                        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0)
                            .format(widget.order.totalPayment),
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
            widget.order.itemsCategory == 'Barang'
                ? Container(
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
                    ))
                : widget.order.itemsCategory == 'Treatment'
                    ? Container(
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
                              "Lokasi Toko",
                              style: orderStatusLabel,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Jalan Kliningan No.6 Buah Batu, Bandung, Indonesia",
                              // widget.order.storeAddress.toString(),
                              style: orderLocation,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
            if (widget.order.itemsCategory == 'Treatment')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          "Detail Waktu",
                          style: orderStatusLabel,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          // "Jalan Kliningan No.6 Buah Batu, Bandung, Indonesia",
                          '${DateFormat('dd MMMM').format(DateTime.parse(widget.order.items!.first['date']))} - ${widget.order.items!.first['time']}',
                          // widget.order.storeAddress.toString(),
                          style: orderLocation,
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
