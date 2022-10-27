import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/order/order.dart';
import 'package:petscape/src/features/order/presentation/order_controler.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/shared/theme.dart';

class CartDetailScreen extends ConsumerStatefulWidget {
  final String usersId;
  final List<Map<Product, int>> cart;
  const CartDetailScreen({Key? key, required this.usersId, required this.cart}) : super(key: key);

  @override
  ConsumerState<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends ConsumerState<CartDetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    final totalPrice = cart.fold(0, (total, item) => total + item.keys.first.price! * item.values.first);

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
            "Order Details",
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
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: whitish,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    buildPrimaryBoxShadow(),
                    buildSecondaryBoxShadow(),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(product.image.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "$qty barang",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(product.price),
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Subtotal: ${NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(product.price! * qty)}',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
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
                  "Total Tagihan",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: black.withOpacity(0.60),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(totalPrice),
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
                  onPressed: () async {
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
                      customerId: widget.usersId,
                      sellerId: cart.first.keys.first.id!,
                      itemsCategory: 'Barang',
                      methodPayment: '',
                      statusPayment: '',
                      tokenPayment: '',
                      totalPayment: totalPrice,
                    );

                    await ref.read(orderControllerProvider.notifier).buy(items);
                    await ref.read(orderControllerProvider.notifier).add(order: order, usersId: widget.usersId);

                    await ref.read(cartControllerProvider.notifier).deleteListItem(widget.usersId, product);
                    await ref.read(cartControllerProvider.notifier).getData(widget.usersId);

                    if (!mounted) return;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BotNavBarScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  child: Text(
                    "Proses Pembayaran",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: whitish,
                    ),
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
