import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/home/presentation/carts_screen.dart';
import 'package:petscape/src/features/home/presentation/products_controller.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';
import 'package:petscape/src/features/product/presentation/product_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<bool> _isSelected = [true, false, false, false];
  List<Product> products = [];
  List<Product> productsFilter = [];

  @override
  void initState() {
    super.initState();
    initProducts();
  }

  Future<void> initProducts() async {
    await ref.read(productsControllerProvider.notifier).getData();
    final returnProducts = ref.read(productsControllerProvider);
    products.addAll(returnProducts);
    productsFilter.addAll(returnProducts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                width: 1.sw,
                height: 86.h,
                decoration: BoxDecoration(
                  color: HexColor('#F2FEFF'),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            Text(
                              "Home Screen",
                              style: smallAppbar,
                            ),
                            Text(
                              // DateFormat('d MMMM').format(DateTime.now()),
                              users.name.toString(),
                              style: subSmallAppbar,
                            ),
                          ],
                        ),
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance.collection("carts").doc(users.uid).update({
                                  "cart": FieldValue.arrayUnion(["QyLvjUlL1iP5PHBFMs1P"])
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot<Object?>>(
                          stream: FirebaseFirestore.instance.collection("carts").doc(users.uid).snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) return const Text("Error");
                            if (snapshot.data?.data() == null) {
                              return const Text("No Data");
                            } else {
                              Map<String, dynamic> item = (snapshot.data!.data() as Map<String, dynamic>);
                              item["id"] = snapshot.data!.id;
                              List carts = List.from(item['items']);
                              return InkWell(
                                onTap: () async {
                                  List<Map<Product, int>> mapProducts = [];
                                  final Map<String, int> itemsMap = {for (var e in carts) e['id']: e['qty']};
                                  final List<String> id = itemsMap.keys.toList();
                                  final List<int> qty = itemsMap.values.toList();

                                  var snapshot = await Future.wait(id
                                      .map((e) => FirebaseFirestore.instance.collection("products").doc(e).get())
                                      .toList());
                                  var list = snapshot.map((e) => e.data()).toList();
                                  List<Product> products = list.map((e) => Product.fromJson(e!)).toList();
                                  for (int i = 0; i < products.length; i++) {
                                    mapProducts.add({products[i]: qty[i]});
                                  }

                                  if (mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartScreen(
                                            items: mapProducts,
                                          ),
                                        ));
                                  }

                                  // var futures = await Future.wait(carts
                                  //     .map((e) => FirebaseFirestore.instance.collection("products").doc(e).get())
                                  //     .toList());
                                  // var list = futures.map((e) => e.data()).toList();
                                  // List<Product> products = list.map((e) => Product.fromJson(e!)).toList();

                                  // if (mounted) {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => CartScreen(
                                  //           carts: products,
                                  //         ),
                                  //       ));
                                  // }
                                },
                                child: Stack(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0, right: 8.0),
                                      child: CircleAvatar(
                                        radius: 14.0,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.shopping_cart,
                                          size: 20.0,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: CircleAvatar(
                                        radius: 8.0,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          item['items'].length.toString(),
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                          "Daily Goals (10/day)",
                          style: barTitle,
                        ),
                        Text(
                          "80%",
                          style: barTitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ChoiceChip(
                            selectedColor: primary,
                            labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                            label: Text(
                              'All',
                              style: _isSelected[0] ? chipSelected : chipUnSelected,
                            ),
                            selected: _isSelected[0],
                            onSelected: (newBoolValue) {
                              setState(() {
                                if (_isSelected[0] == false) {
                                  _isSelected[0] = true;
                                  _isSelected[1] = false;
                                  _isSelected[2] = false;
                                  _isSelected[3] = false;

                                  products.clear();
                                  products.addAll(productsFilter);
                                }
                                // articles.clear();
                                // articles.addAll(article);
                              });
                            },
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          ChoiceChip(
                            selectedColor: primary,
                            labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                            label: Text(
                              'Dog',
                              style: _isSelected[1] ? chipSelected : chipUnSelected,
                            ),
                            selected: _isSelected[1],
                            onSelected: (newBoolValue) {
                              setState(() {
                                if (_isSelected[1] == false) {
                                  _isSelected[1] = true;
                                  _isSelected[0] = false;
                                  _isSelected[2] = false;
                                  _isSelected[3] = false;

                                  final drugsCategory =
                                      productsFilter.where((element) => element.category == 'drugs').toList();
                                  products.clear();
                                  products.addAll(drugsCategory);
                                }
                                // articles.clear();
                                // articles.addAll(article);
                              });
                            },
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          ChoiceChip(
                            selectedColor: primary,
                            labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                            label: Text(
                              'Cat',
                              style: _isSelected[2] ? chipSelected : chipUnSelected,
                            ),
                            selected: _isSelected[2],
                            onSelected: (newBoolValue) {
                              setState(() {
                                if (_isSelected[2] == false) {
                                  _isSelected[2] = true;
                                  _isSelected[0] = false;
                                  _isSelected[1] = false;
                                  _isSelected[3] = false;

                                  final drugsCategory =
                                      productsFilter.where((element) => element.category == 'outfit').toList();
                                  products.clear();
                                  products.addAll(drugsCategory);
                                }
                                // articles.clear();
                                // articles.addAll(article);
                              });
                            },
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          ChoiceChip(
                            selectedColor: primary,
                            labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                            label: Text(
                              'Others',
                              style: _isSelected[3] ? chipSelected : chipUnSelected,
                            ),
                            selected: _isSelected[3],
                            onSelected: (newBoolValue) {
                              setState(() {
                                if (_isSelected[3] == false) {
                                  _isSelected[3] = true;
                                  _isSelected[0] = false;
                                  _isSelected[1] = false;
                                  _isSelected[2] = false;

                                  final drugsCategory =
                                      productsFilter.where((element) => element.category == 'test').toList();
                                  products.clear();
                                  products.addAll(drugsCategory);
                                }
                                // articles.clear();
                                // articles.addAll(article);
                              });
                            },
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      width: 1.sw,
                      height: 1,
                      color: graySecond,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // ListView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: products.length,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     return Column(
                    //       children: [
                    //         Column(
                    //           children: [
                    //             InkWell(
                    //               onTap: () async {},
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       SizedBox(
                    //                         width: 222.w,
                    //                         child: Text(
                    //                           products[index].name.toString(),
                    //                           style: itemTitle,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 6.h,
                    //                       ),
                    //                       SizedBox(
                    //                         width: 300,
                    //                         child: Text(
                    //                           products[index].desc.toString(),
                    //                           overflow: TextOverflow.fade,
                    //                           style: itemSource,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 12.h,
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           TextButton(
                    //                             onPressed: () {},
                    //                             style: TextButton.styleFrom(
                    //                               foregroundColor: graySecond,
                    //                               backgroundColor: graySecond,
                    //                             ),
                    //                             child: Text(
                    //                               products[index].category.toString(),
                    //                               style: articleTag,
                    //                             ),
                    //                           ),
                    //                           const SizedBox(
                    //                             width: 6,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 2.h,
                    //             ),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.end,
                    //               children: [
                    //                 Image.asset(
                    //                   'assets/images/share-icon.png',
                    //                   width: 18.w,
                    //                   height: 18.h,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 34.w,
                    //                 ),
                    //                 Image.asset(
                    //                   'assets/images/option-icon.png',
                    //                   width: 4.w,
                    //                   height: 18.h,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 10.w,
                    //                 )
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 15.h,
                    //         ),
                    //         Container(
                    //           width: 1.sw,
                    //           height: 1,
                    //           color: graySecond,
                    //         ),
                    //         SizedBox(
                    //           height: 24.h,
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("products").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return const Text("Error");
                        if (snapshot.data == null) return Container();
                        if (snapshot.data!.docs.isEmpty) {
                          return const Text("No Data");
                        }
                        final data = snapshot.data!;
                        final listProducts = ['FWZRr7lkx6N5xkwiArUH', 'MPHbqQSgdPC3AZzYxQQE', 'PZWCg5YXpWV9r9Lk7Vpg'];

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item = (data.docs[index].data() as Map<String, dynamic>);
                            item["id"] = data.docs[index].id;
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const ProductScreen(),
                                            ));
                                        // var futures = await Future.wait([
                                        //   FirebaseFirestore.instance
                                        //       .collection("products")
                                        //       .doc("FWZRr7lkx6N5xkwiArUH")
                                        //       .get(),
                                        //   FirebaseFirestore.instance
                                        //       .collection("products")
                                        //       .doc("MPHbqQSgdPC3AZzYxQQE")
                                        //       .get(),
                                        //   FirebaseFirestore.instance
                                        //       .collection("products")
                                        //       .doc("PZWCg5YXpWV9r9Lk7Vpg")
                                        //       .get(),
                                        // ]);
                                        // var list = futures.map((e) => e.data()).toList();
                                        // print(list);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 222.w,
                                                child: Text(
                                                  item['name'],
                                                  style: itemTitle,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: Text(
                                                  item['desc'],
                                                  overflow: TextOverflow.fade,
                                                  style: itemSource,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {},
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: graySecond,
                                                      backgroundColor: graySecond,
                                                    ),
                                                    child: Text(
                                                      item['category'],
                                                      style: articleTag,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/images/share-icon.png',
                                          width: 18.w,
                                          height: 18.h,
                                        ),
                                        SizedBox(
                                          width: 34.w,
                                        ),
                                        Image.asset(
                                          'assets/images/option-icon.png',
                                          width: 4.w,
                                          height: 18.h,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  width: 1.sw,
                                  height: 1,
                                  color: graySecond,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
