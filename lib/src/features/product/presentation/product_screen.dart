import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/cart/presentation/cart_controller.dart';
import 'package:petscape/src/features/product/presentation/product_add_screen.dart';
import 'package:petscape/src/features/product/presentation/product_controller.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/product/presentation/product_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static const routeName = '/product';

  final String type;
  final String usersId;
  const ProductScreen({Key? key, required this.usersId, required this.type}) : super(key: key);

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  bool isLoading = false;
  List<Map<String, bool>> isSelected = [
    {'All': true},
    {'Dog': false},
    {'Cat': false},
    {'Others': false},
  ];
  List<Product> products = [];
  List<Product> productsFilter = [];

  @override
  void initState() {
    super.initState();
    initProducts();
  }

  Future<void> initProducts() async {
    setState(() {
      isLoading = true;
    });

    await ref.read(productControllerProvider.notifier).getData();
    await ref.read(cartControllerProvider.notifier).getData(widget.usersId);
    final returnProducts = ref.read(productControllerProvider);
    final tempProducts = returnProducts.where((element) => element.type == widget.type).toList();

    setState(() {
      products.addAll(tempProducts);
      productsFilter.addAll(tempProducts);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartsLength = ref.watch(cartControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: neutral,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/icons/arrow-left-icon.png"),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Container(
                      width: 222.w,
                      height: 36.h,
                      decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                        buildPrimaryBoxShadow(),
                      ]),
                      child: Center(
                        child: TextField(
                          style: homeSearchText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Image.asset(
                                "assets/icons/search-icon.png",
                                scale: 4,
                              ),
                              hintText: "Search in food",
                              hintStyle: homeSearchHint,
                              contentPadding: EdgeInsets.only(left: 13.w, top: 4.h, bottom: 7.h)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductAddScreen()));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CartScreen(
                            //               usersId: widget.usersId,
                            //             )));
                          },
                          icon: Image.asset(
                            "assets/icons/bag-icon.png",
                          ),
                        ),
                        isLoading
                            ? Positioned(
                                top: 2,
                                right: 4,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
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
                              )
                            : Positioned(
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
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  width: 324.w,
                  height: 154.h,
                  padding: EdgeInsets.only(left: 13.w, top: 20.h, bottom: 4.h, right: 130.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: secondary,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/petscape/food-bg-img.png'), fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Our Choice",
                        style: homeWhiteSubTitle,
                      ),
                      Text(
                        "Magnus Premium Especial",
                        style: homeWhiteTitle,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      SizedBox(
                        width: 140.w,
                        height: 32.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(whitish),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 21.w, vertical: 4.h),
                            ),
                          ),
                          child: Text(
                            "Beli Sekarang",
                            style: homeBlackButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Categories",
                  style: homeCategoryTitle,
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 55.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: isSelected.map((e) {
                        return e.values.first
                            ? Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: SizedBox(
                                      width: 68.w,
                                      height: 36.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            for (var element in isSelected) {
                                              if (element.keys.first == e.keys.first) {
                                                element.update(element.keys.first, (value) => true);
                                              } else {
                                                element.update(element.keys.first, (value) => false);
                                              }
                                            }

                                            if (e.keys.first == 'All') {
                                              final filter = productsFilter;
                                              products.clear();
                                              products.addAll(filter);
                                            } else {
                                              final filter = productsFilter
                                                  .where((element) => element.category == e.keys.first.toLowerCase())
                                                  .toList();
                                              products.clear();
                                              products.addAll(filter);
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                        ),
                                        child: e.keys.first == 'Others'
                                            ? Text(
                                                e.keys.first,
                                                style: productCategoryBlack,
                                              )
                                            : Text(
                                                e.keys.first,
                                                style: productCategoryWhite,
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 81.w,
                                    height: 36.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          for (var element in isSelected) {
                                            if (element.keys.first == e.keys.first) {
                                              element.update(element.keys.first, (value) => true);
                                            } else {
                                              element.update(element.keys.first, (value) => false);
                                            }
                                          }

                                          if (e.keys.first == 'All') {
                                            final filter = productsFilter;
                                            products.clear();
                                            products.addAll(filter);
                                          } else {
                                            final filter = productsFilter
                                                .where((element) => element.category == e.keys.first.toLowerCase())
                                                .toList();
                                            products.clear();
                                            products.addAll(filter);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                                      child: Container(
                                        width: 81.w,
                                        height: 36.h,
                                        decoration: BoxDecoration(
                                            color: whitish,
                                            borderRadius: BorderRadius.circular(4.r),
                                            boxShadow: [
                                              buildPrimaryBoxShadow(),
                                            ]),
                                        child: Center(
                                          child: Text(
                                            e.keys.first,
                                            style: productCategoryBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                ],
                              );
                      }).toList(),
                      // ...isSelected.map((e) => null).toList(),
                      // isSelected[0].entries.map((e) {
                      //   Logger().e(e);
                      //   return e.value
                      //       ? Column(
                      //           children: [
                      //             ClipRRect(
                      //               borderRadius: BorderRadius.circular(4.r),
                      //               child: SizedBox(
                      //                 width: 68.w,
                      //                 height: 36.h,
                      //                 child: ElevatedButton(
                      //                   onPressed: () {},
                      //                   style: ElevatedButton.styleFrom(
                      //                     backgroundColor: primary,
                      //                   ),
                      //                   child: Text(
                      //                     "All",
                      //                     style: productCategoryWhite,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 16.w,
                      //             ),
                      //           ],
                      //         )
                      //       : Column(
                      //           children: [
                      //             SizedBox(
                      //               width: 81.w,
                      //               height: 36.h,
                      //               child: ElevatedButton(
                      //                 onPressed: () {},
                      //                 style: ElevatedButton.styleFrom(
                      //                     padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
                      //                 child: Container(
                      //                   width: 81.w,
                      //                   height: 36.h,
                      //                   decoration: BoxDecoration(
                      //                       color: whitish,
                      //                       borderRadius: BorderRadius.circular(4.r),
                      //                       boxShadow: [
                      //                         buildPrimaryBoxShadow(),
                      //                       ]),
                      //                   child: Center(
                      //                     child: Text(
                      //                       "Dog",
                      //                       style: productCategoryBlack,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 16.w,
                      //             ),
                      //           ],
                      //         );
                      // }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Recommendation For You",
                  style: homeCategoryTitle,
                ),
                SizedBox(
                  height: 12.h,
                ),
                isLoading
                    ?
                    // gridview with shimmer
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 242.h, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w, crossAxisCount: 2),
                        itemCount: products.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: 154.w,
                          height: 242.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                            usersId: widget.usersId,
                                            product: products[index],
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 154.w,
                              height: 242.h,
                              decoration: BoxDecoration(
                                color: whitish,
                                borderRadius: BorderRadius.circular(4.r),
                                boxShadow: [
                                  buildPrimaryBoxShadow(),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.r),
                                      topRight: Radius.circular(4.r),
                                    ),
                                    child: Image.network(
                                      // "https://i.pinimg.com/1200x/da/66/47/da6647f1615e67791fa6644d1a7663fa.jpg",
                                      products[index].image.toString(),
                                      width: 154.w,
                                      height: 146.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 140.w,
                                          child: Text(
                                            // "Pharma Hemp Chicken Treats",
                                            products[index].name.toString(),
                                            style: producOntItemTitle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          // "Rp 56.000",
                                          // "Rp ${products[index].price}",
                                          // format price to idr
                                          NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(products[index].price),
                                          style: producOntItemPrice,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/rating-icon.png",
                                              width: 16.w,
                                              height: 16.h,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              "4.5",
                                              style: producOntItemRating,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Container(
                                              width: 1.w,
                                              height: 10.h,
                                              color: black.withOpacity(0.60),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              "Terjual ${products[index].sold}",
                                              style: producOntItemRating,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // "Bandung",
                                              products[index].location.toString(),
                                              style: producOntItemLocation,
                                            ),
                                            products[index].category!.toLowerCase() == "dog"
                                                ? Image.asset(
                                                    "assets/icons/dog-icon.png",
                                                    width: 16.w,
                                                    height: 16.h,
                                                  )
                                                : Image.asset(
                                                    "assets/icons/cat-icon.png",
                                                    width: 16.w,
                                                    height: 16.h,
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
