import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
import 'package:petscape/src/features/cart/presentation/cart_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/vets/presentation/booking_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Users users;
  final Product product;
  const ProductDetailScreen({Key? key, required this.product, required this.users}) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  late Product products;
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    products = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final cartsLength = ref.watch(cartControllerProvider);
    return Scaffold(
      backgroundColor: whitish,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: AppBar(
          primary: true,
          backgroundColor: whitish,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/arrow-left-icon.png"),
          ),
          title: Text(
            "Detail ${products.type!.replaceRange(0, 1, products.type![0].toUpperCase())}",
            style: appBarTitle,
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreen(
                                  users: widget.users,
                                )));
                  },
                  icon: Image.asset(
                    "assets/icons/bag-icon.png",
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 4,
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        cartsLength.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              products.image.toString(),
              width: 1.sw,
              height: 290.h,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(products.price),
                        style: productDetPrice,
                      ),
                      Visibility(
                        visible: products.type != "treatment",
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  itemCount--;
                                });
                                if (itemCount <= 1) {
                                  itemCount = 1;
                                }
                              },
                              child: Image.asset(
                                itemCount > 1 ? "assets/icons/subtract-primary-icon.png" : "assets/icons/subtract-icon.png",
                                width: 30.w,
                                height: 30.h,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              itemCount.toString(),
                              style: productDetItemCount,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    itemCount++;
                                  });
                                },
                                child: Image.asset(
                                  "assets/icons/add-primary-icon.png",
                                  width: 30.w,
                                  height: 30.h,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    products.name.toString(),
                    style: productItemTitle,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/rating-icon.png",
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "4.5",
                        style: productItemRatingBlack,
                      ),
                      Text(
                        "/5",
                        style: productItemRatingBlackGray,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        width: 1.w,
                        height: 15.h,
                        color: black.withOpacity(0.60),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        products.sold.toString(),
                        style: productItemRatingBlack,
                      ),
                      Text(
                        " Terjual",
                        style: productItemRatingBlackGray,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 1.sw,
              height: 1.h,
              color: gray,
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${products.type!.replaceRange(0, 1, products.type![0].toUpperCase())} Description",
                    style: productDescBigTitle,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Visibility(
                    visible: products.type != "treatment",
                    child: Row(
                      children: [
                        Text(
                          "Stok:",
                          style: productDescSubTitleBlack,
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        Text(
                          '${products.stock} ',
                          style: productDescSubTitlePrimary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kategori:",
                        style: productDescSubTitleBlack,
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        products.category.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Toko:",
                        style: productDescSubTitleBlack,
                      ),
                      SizedBox(
                        width: 66.w,
                      ),
                      Text(
                        products.seller.toString(),
                        style: productDescSubTitlePrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lokasi:",
                        style: productDescSubTitleBlack,
                      ),
                      SizedBox(
                        width: 56.w,
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          products.location.toString(),
                          style: productDescSubTitlePrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    products.desc.toString(),
                    style: productDescText,
                  ),
                  SizedBox(
                    height: 106.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: products.type != 'treatment'
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
              width: 1.sw,
              height: 72.h,
              decoration: BoxDecoration(color: whitish, boxShadow: [
                buildSecondaryBoxShadow(),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      width: 154.w,
                      height: 42.h,
                      child: OutlinedButton(
                        onPressed: () async {
                          final db = FirebaseFirestore.instance.collection("carts").doc(widget.users.uid.toString());
                          final snapshot = await db.get();
                          final data = snapshot.data() as Map<String, dynamic>;
                          final items = data["items"];
                          final temp = [];
                          if (items != null && items.length > 0) {
                            final item = items.firstWhere((element) => element["id"] == products.id, orElse: () => null);
                            if (item != null) {
                              for (var i = 0; i < items.length; i++) {
                                if (items[i]["id"] == products.id) {
                                  items[i]["qty"] += itemCount;
                                }
                                temp.add(items[i]);
                              }
                            } else {
                              final newItem = {
                                "id": products.id,
                                "qty": itemCount,
                              };
                              temp.add(newItem);
                              temp.addAll(items);
                            }

                            await db.update({
                              "items": temp,
                            });
                          } else {
                            await db.update({
                              'usersId': widget.users.uid.toString(),
                              "items": FieldValue.arrayUnion([
                                {
                                  'id': products.id,
                                  'qty': itemCount,
                                }
                              ])
                            });
                          }

                          await ref.read(cartControllerProvider.notifier).getData(widget.users.uid.toString());

                          setState(() {
                            itemCount = 1;
                          });

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Berhasil ditambahkan ke keranjang"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.w,
                            color: primary,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/bag-primary.png",
                              width: 23.w,
                              height: 23.h,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              "Keranjang",
                              style: productKeranjang,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      width: 154.w,
                      height: 42.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                        ),
                        child: Text(
                          "Beli Sekarang",
                          style: productBuy,
                        ),
                      ),
                    ),
                  ),
                ],
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingScreen(
                                  product: products,
                                  users: widget.users,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    child: Text(
                      "Pesan Sekarang - ${NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(products.price)}",
                      style: vetBookOnBtnWhite,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
