import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/product/presentation/product_controller.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/shared/theme.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final Order order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  List<Product> products = [];
  Vets vets = Vets();

  @override
  void initState() {
    super.initState();
    getListProduct();
  }

  Future<void> getListProduct() async {
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
    } else {
      final vet = widget.order.items?.first['vets'];
      setState(() {
        vets = Vets.fromJson(vet);
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
      body: widget.order.itemsCategory != 'Appointment'
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.w),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Visibility(
                      visible: widget.order.statusPayment == 'settlement' || widget.order.statusPayment == 'success'
                          ? false
                          : true,
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
                          widget.order.itemsCategory == 'Barang'
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                              products[index].image.toString(),
                                              width: 64.w,
                                              height: 56.h,
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
                              : widget.order.itemsCategory == 'Treatment'
                                  ? ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: products.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.0.w),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(6.r),
                                                child: Image.network(
                                                  products[index].image.toString(),
                                                  width: 64.w,
                                                  height: 56.h,
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
                                                    products[index].name.toString(),
                                                    style: orderStatusLabel,
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Text(
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
                                      physics: const NeverScrollableScrollPhysics(),
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
                                                    orderItem['name'],
                                                    style: orderStatusLabel,
                                                  ),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Text(
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
                                  widget.order.address.toString(),
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
                                      widget.order.address.toString(),
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
                                  '${DateFormat('dd MMMM').format(DateTime.parse(widget.order.items!.first['date']))} - ${widget.order.items!.first['time']}',
                                  style: orderLocation,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      )
                  ],
                ),
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
                          "Appointment Detail",
                          style: orderStatusLabel,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.network(
                                vets.image.toString(),
                                width: 54.w,
                                height: 54.h,
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
                                  vets.name.toString(),
                                  style: orderStatusLabel,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  vets.degree.toString(),
                                  style: orderLocation,
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
                          height: 12.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Place",
                              style: orderTotalTxt,
                            ),
                            Text(
                              'In-Person',
                              style: orderPriceSmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lokasi",
                              style: orderTotalTxt,
                            ),
                            Text(
                              vets.address.toString(),
                              style: orderPriceSmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jam",
                              style: orderTotalTxt,
                            ),
                            Text(
                              "12:00-13:00",
                              style: orderPriceSmall,
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
                          "Lokasi Praktik",
                          style: orderStatusLabel,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Jl. Kliningan No.6 RT 02 RW 05, Bandung, Jawa Barat, Indonesia",
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
