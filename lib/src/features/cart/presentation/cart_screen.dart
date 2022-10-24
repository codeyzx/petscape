import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
import 'package:petscape/src/features/cart/presentation/cart_detail_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';
import 'package:petscape/src/shared/theme.dart';

class CartScreen extends ConsumerStatefulWidget {
  final String usersId;
  const CartScreen({Key? key, required this.usersId}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<Map<Product, int>> cart = [];
  List<Map<Product, int>> cartFilter = [];
  List<Map<Product, int>> cartFilterz = [];
  // List<Product> items = [];
  // int qty = 0;

  @override
  void initState() {
    super.initState();
    initCart();
  }

  Future<void> initCart() async {
    await ref.read(cartControllerProvider.notifier).getData(widget.usersId);
    final cartTemp = ref.read(cartControllerProvider);

    List<Map<Product, int>> temp = [];

    for (var element in cartTemp) {
      temp.add(element);
    }

    // List<Product> tempItems = temp.map((e) => e.keys.first).toList();

    setState(() {
      cart.addAll(temp);
      cartFilter.addAll(temp);
      cartFilterz.addAll(temp);
      // items.addAll(tempItems);
    });
  }

  // void updatePrice() {
  //   int price = 0;
  //   for (var element in cart) {
  //     price += element.keys.first.price! * element.values.first;
  //   }
  //   setState(() {
  //     totalPrice = price;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Product> items = [];
    int cobaPrice = 0;
    if (cartFilterz.isNotEmpty) {
      items = cartFilterz.map((e) => e.keys.first).toList();
      cobaPrice = cartFilterz.map((e) => e.keys.first.price! * e.values.first).reduce((value, element) => value + element);
    } else {
      items = [];
      cobaPrice = 0;
    }
    // int cobaPrice = items.fold(
    //     0,
    //     (previousValue, element) =>
    //         previousValue +
    //         element.price! * cart.firstWhere((element2) => element2.keys.first.id == element.id).values.first);

    // final cart = ref.watch(cartControllerProvider);
    // final items = cart.map((e) => e.keys.first).toList();
    // final totalPrice = items.fold(0, (previousValue, element) => previousValue + element.price!);
    return Scaffold(
      backgroundColor: neutral,
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
            "Cart",
            style: appBarTitle,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final product = cart[index].keys.first;
            final qty = cart[index].values.first;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: whitish,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    buildSecondaryBoxShadow(),
                    buildPrimaryBoxShadow(),
                  ],
                ),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: cartFilterz.contains(cart[index]),
                  onChanged: (value) {
                    setState(() {
                      if (cartFilterz.contains(cart[index])) {
                        cartFilterz.remove(cart[index]); // unselect
                      } else {
                        cartFilterz.add(cart[index]); // select
                      }

                      // items.clear();
                      // items.addAll(cartFilter.map((e) => e.keys.first).toList());
                      // cart.clear();
                      // cart.addAll(cartFilter);
                    });
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 62.w,
                          height: 62.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: NetworkImage(product.image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    product.name.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete Item"),
                                        content: const Text("Are you sure want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                cartFilterz.remove(cart[index]);
                                                cart.remove(cart[index]);
                                              });
                                              await ref
                                                  .read(cartControllerProvider.notifier)
                                                  .deleteItem(widget.usersId, product);
                                              await ref.read(cartControllerProvider.notifier).getCartsLength(widget.usersId);

                                              if (!mounted) return;
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 20.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: const Icon(
                                      size: 16,
                                      //  const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Text(
                                  // "Rp ${product.price.toString()}",
                                  NumberFormat.currency(
                                    locale: "id",
                                    symbol: "Rp ",
                                    decimalDigits: 0,
                                  ).format(product.price),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                                SizedBox(width: 25.w),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        // update qty from product index
                                        if (qty > 1) {
                                          setState(() {
                                            cart[index].update(product, (value) => --value);
                                          });
                                          ref.read(cartControllerProvider.notifier).decrementItem(widget.usersId, product);
                                        }
                                        // decrement itemCount from firestore
                                        // setState(() {
                                        // qty++;
                                        // // items.clear();
                                        // // cartFilter.map((e) => e.update(product, (value) => value - 1)).toList();
                                        // // items.addAll(cartFilter.map((e) => e.keys.first).toList());
                                        // print(qty);
                                        // });

                                        // updatePrice(index);
                                      },
                                      child: Image.asset(
                                        qty > 1
                                            ? "assets/icons/subtract-primary-icon.png"
                                            : "assets/icons/subtract-icon.png",
                                        width: 20.w,
                                        height: 20.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      qty.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          // update qty from product index
                                          setState(() {
                                            cart[index].update(product, (value) => ++value);
                                          });
                                          ref.read(cartControllerProvider.notifier).incrementItem(widget.usersId, product);

                                          // updatePrice(index);
                                        },
                                        child: Image.asset(
                                          "assets/icons/add-primary-icon.png",
                                          width: 20.w,
                                          height: 20.h,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     physics: const BouncingScrollPhysics(),
      //     itemCount: cart.length,
      //     itemBuilder: (context, index) {
      //       final product = cart[index].keys.first;
      //       qty = cart[index].values.first;
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: CheckboxListTile(
      //           value: cartFilter.contains(cart[index]),
      //           onChanged: (value) {
      //             setState(() {
      //               if (cartFilter.contains(cart[index])) {
      //                 cartFilter.remove(cart[index]); // unselect
      //               } else {
      //                 cartFilter.add(cart[index]); // select
      //               }

      //               items.clear();
      //               items.addAll(cartFilter.map((e) => e.keys.first).toList());
      //             });
      //           },
      //           title: Row(
      //             children: [
      //               Container(
      //                 width: 100.w,
      //                 height: 100.h,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10.r),
      //                   image: DecorationImage(
      //                     image: NetworkImage(product.image.toString()),
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(width: 10.w),
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     width: 140,
      //                     child: Text(
      //                       product.name.toString(),
      //                       style: GoogleFonts.poppins(
      //                         fontSize: 16.sp,
      //                         fontWeight: FontWeight.w500,
      //                         color: black,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height: 5.h),
      //                   Text(
      //                     // "Rp ${product.price.toString()}",
      //                     NumberFormat.currency(
      //                       locale: "id",
      //                       symbol: "Rp ",
      //                       decimalDigits: 0,
      //                     ).format(product.price),
      //                     style: GoogleFonts.poppins(
      //                       fontSize: 14.sp,
      //                       fontWeight: FontWeight.w500,
      //                       color: black,
      //                     ),
      //                   ),
      //                   SizedBox(height: 5.h),
      //                   Row(
      //                     children: [
      //                       InkWell(
      //                         onTap: () async {
      //                           // update qty from product index
      //                           if (qty > 1) {
      //                             setState(() {
      //                               cart[index].update(product, (value) => --value);
      //                             });
      //                           }
      //                           // decrement itemCount from firestore
      //                           // await ref.read(cartControllerProvider.notifier).decrementItem(widget.usersId, product);
      //                           // setState(() {
      //                           // qty++;
      //                           // // items.clear();
      //                           // // cartFilter.map((e) => e.update(product, (value) => value - 1)).toList();
      //                           // // items.addAll(cartFilter.map((e) => e.keys.first).toList());
      //                           // print(qty);
      //                           // });

      //                           // updatePrice(index);
      //                         },
      //                         child: Image.asset(
      //                           qty > 1 ? "assets/icons/subtract-primary-icon.png" : "assets/icons/subtract-icon.png",
      //                           width: 20.w,
      //                           height: 20.h,
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 8.w,
      //                       ),
      //                       Text(
      //                         qty.toString(),
      //                         style: GoogleFonts.poppins(
      //                           fontSize: 16.sp,
      //                           fontWeight: FontWeight.w400,
      //                           color: black,
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 8.w,
      //                       ),
      //                       InkWell(
      //                           onTap: () async {
      //                             // update qty from product index
      //                             setState(() {
      //                               cart[index].update(product, (value) => ++value);
      //                             });
      //                             // await ref.read(cartControllerProvider.notifier).incrementItem(widget.usersId, product);

      //                             // updatePrice(index);
      //                           },
      //                           child: Image.asset(
      //                             "assets/icons/add-primary-icon.png",
      //                             width: 20.w,
      //                             height: 20.h,
      //                           )),
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),

      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        width: 1.sw,
        height: 72.h,
        decoration: BoxDecoration(color: whitish, boxShadow: [
          buildSecondaryBoxShadow(),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Total: ${items.length} Items",
                  // "Total: ${cart.map((e) => e.keys.first).toList().length} Items",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: black.withOpacity(0.60),
                  ),
                ),
                Text(
                  // "Rp 56.000",
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(cobaPrice),
                  // ).format(cart
                  //     .map((e) => e.keys.first)
                  //     .toList()
                  //     .fold(0, (previousValue, element) => previousValue + element.price!)),
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 154.w,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Logger().e(cartFilterz);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartDetailScreen(usersId: widget.usersId, cart: cartFilterz),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  child: Text(
                    "Checkout",
                    style: productBuy,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
// import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
// import 'package:petscape/src/features/home/widgets/box_shadow.dart';
// import 'package:petscape/src/features/product/domain/product/product.dart';
// import 'package:petscape/src/shared/theme.dart';

// class CartScreen extends ConsumerStatefulWidget {
//   final String usersId;
//   const CartScreen({Key? key, required this.usersId}) : super(key: key);

//   @override
//   ConsumerState<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends ConsumerState<CartScreen> {
//   List<Map<Product, int>> cart = [];
//   List<Product> items = [];
//   int totalPrice = 0;
//   int itemCount = 0;
//   @override
//   void initState() {
//     super.initState();
//     initCart();
//   }

//   Future<void> initCart() async {
//     Logger().i("init cart");
//     await ref.read(cartControllerProvider.notifier).getData(widget.usersId);

//     final cartTemp = ref.read(cartControllerProvider);
//     List<Map<Product, int>> temp = [];
//     cart.clear();
//     items.clear();
//     for (var element in cartTemp) {
//       temp.add(element);
//     }
//     List<Product> tempProduct = temp.map((e) => e.keys.first).toList();
//     int tempTotalPrice = tempProduct.fold(0, (previousValue, element) => previousValue + element.price!);
//     setState(() {
//       cart.addAll(temp);
//       items.addAll(tempProduct);
//       totalPrice = tempTotalPrice;
//     });
//   }

//   void updatePrice(int index) {
//     setState(() {
//       totalPrice = totalPrice + cart[index].keys.first.price!;
//     });
//   }

//   Future<void> updateCart() async {
//     await ref.read(cartControllerProvider.notifier).getData(widget.usersId);

//     final cartTemp = ref.read(cartControllerProvider);
//     List<Map<Product, int>> temp = [];
//     cart.clear();
//     items.clear();
//     for (var element in cartTemp) {
//       temp.add(element);
//     }
//     List<Product> tempProduct = temp.map((e) => e.keys.first).toList();
//     int tempTotalPrice = tempProduct.fold(0, (previousValue, element) => previousValue + element.price!);
//     setState(() {
//       cart.addAll(temp);
//       items.addAll(tempProduct);
//       totalPrice = tempTotalPrice;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final cart = ref.watch(cartControllerProvider);
//     // final items = cart.map((e) => e.keys.first).toList();
//     // final totalPrice = items.fold(0, (previousValue, element) => previousValue + element.price!);
//     return Scaffold(
//       backgroundColor: neutral,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(66.h),
//         child: AppBar(
//           primary: true,
//           backgroundColor: whitish,
//           elevation: 0,
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Image.asset("assets/icons/arrow-left-icon.png"),
//           ),
//           title: Text(
//             "Cart",
//             style: appBarTitle,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemCount: cart.length,
//           itemBuilder: (context, index) {
//             final product = cart[index].keys.first;
//             final qty = cart[index].values.first;
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CheckboxListTile(
//                 value: cart.contains(cart[index]),
//                 onChanged: (value) {
//                   setState(() {
//                     if (cart.contains(cart[index])) {
//                       cart.remove(cart[index]); // unselect
//                       totalPrice = totalPrice - product.price!;
//                       items = items.where((element) => element != product).toList();
//                     } else {
//                       cart.add(cart[index]); // select
//                       totalPrice = totalPrice + product.price!;
//                       items.add(product);
//                     }
//                   });
//                 },
//                 title: Row(
//                   children: [
//                     Container(
//                       width: 100.w,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         image: DecorationImage(
//                           image: NetworkImage(product.image.toString()),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10.w),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 140,
//                           child: Text(
//                             product.name.toString(),
//                             style: GoogleFonts.poppins(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w500,
//                               color: black,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Text(
//                           // "Rp ${product.price.toString()}",
//                           NumberFormat.currency(
//                             locale: "id",
//                             symbol: "Rp ",
//                             decimalDigits: 0,
//                           ).format(product.price),
//                           style: GoogleFonts.poppins(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500,
//                             color: black,
//                           ),
//                         ),
//                         SizedBox(height: 5.h),
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 // decrement itemCount from firestore
//                                 await ref.read(cartControllerProvider.notifier).decrementItem(widget.usersId, product);
//                                 await updateCart();
//                                 // updatePrice(index);
//                               },
//                               child: Image.asset(
//                                 qty > 1 ? "assets/icons/subtract-primary-icon.png" : "assets/icons/subtract-icon.png",
//                                 width: 20.w,
//                                 height: 20.h,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 8.w,
//                             ),
//                             Text(
//                               qty.toString(),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: black,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 8.w,
//                             ),
//                             InkWell(
//                                 onTap: () async {
//                                   await ref.read(cartControllerProvider.notifier).incrementItem(widget.usersId, product);
//                                   await updateCart();
//                                   // updatePrice(index);
//                                 },
//                                 child: Image.asset(
//                                   "assets/icons/add-primary-icon.png",
//                                   width: 20.w,
//                                   height: 20.h,
//                                 )),
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       bottomSheet: Container(
//         padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
//         width: 1.sw,
//         height: 72.h,
//         decoration: BoxDecoration(color: whitish, boxShadow: [
//           buildSecondaryBoxShadow(),
//         ]),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   "Total: ${items.length} Items",
//                   // "Total: ${cart.map((e) => e.keys.first).toList().length} Items",
//                   style: GoogleFonts.poppins(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     color: black.withOpacity(0.60),
//                   ),
//                 ),
//                 Text(
//                   // "Rp 56.000",
//                   NumberFormat.currency(
//                     locale: 'id',
//                     symbol: 'Rp ',
//                     decimalDigits: 0,
//                   ).format(totalPrice),
//                   // ).format(cart
//                   //     .map((e) => e.keys.first)
//                   //     .toList()
//                   //     .fold(0, (previousValue, element) => previousValue + element.price!)),
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: black,
//                   ),
//                 ),
//               ],
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(4.r),
//               child: SizedBox(
//                 width: 154.w,
//                 height: 42.h,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Logger().e(cart);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primary,
//                   ),
//                   child: Text(
//                     "Checkout",
//                     style: productBuy,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }