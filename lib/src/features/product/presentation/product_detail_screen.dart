import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';
import 'package:petscape/src/shared/theme.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product cagesFromScan;
  const ProductDetailScreen({super.key, required this.cagesFromScan});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true, // <-- Set this
      appBar: AppBar(
        backgroundColor: Colors.transparent, // <-- this
        shadowColor: Colors.transparent, // <-- and this
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            image: NetworkImage(widget.cagesFromScan.image.toString() ?? 'https://picsum.photos/500/300?random=1'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.cagesFromScan.name.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.cagesFromScan.desc.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Rp. ${widget.cagesFromScan.price.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Stock: ${widget.cagesFromScan.stock.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Category: ${widget.cagesFromScan.category.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Location: ${widget.cagesFromScan.location.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Seller: ${widget.cagesFromScan.seller.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //create cart increment and decrement widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        onPressed: () {
                          setState(() {
                            if (qty > 1) {
                              qty--;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      qty.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        onPressed: () {
                          setState(() {
                            qty++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.10), offset: const Offset(0, -2), blurRadius: 4, spreadRadius: 0),
        ]),
        child: Material(
          child: InkWell(
            onTap: () async {
              await FirebaseFirestore.instance.collection("carts").doc(users.uid).update({
                'userId': users.uid,
                "items": FieldValue.arrayUnion([
                  {
                    'id': widget.cagesFromScan.id,
                    'qty': qty,
                  }
                ])
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.greenAccent,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'ADD TO CART',
                  style: btmsheet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
