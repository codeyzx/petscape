import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/feed/domain/feed.dart';
import 'package:petscape/src/features/feed/presentation/feed_controller.dart';
import 'package:petscape/src/features/feed/presentation/feed_detail_screen.dart';
import 'package:petscape/src/features/feed/presentation/feed_add_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/shared/theme.dart';

class FeedScreen extends ConsumerStatefulWidget {
  static const routeName = 'feed';
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  bool isLoading = false;
  List<Map<String, bool>> isSelected = [
    {'All': true},
    {'Dog': false},
    {'Cat': false},
    {'Donation': false},
  ];
  List<Feed> feed = [];
  List<Feed> feedFilter = [];

  @override
  void initState() {
    super.initState();
    initProducts();
  }

  Future<void> initProducts() async {
    setState(() {
      isLoading = true;
    });

    await ref.read(feedControllerProvider.notifier).getData();
    final returnProducts = ref.read(feedControllerProvider);

    setState(() {
      feed.addAll(returnProducts);
      feedFilter.addAll(returnProducts);
      isLoading = false;
    });
  }

  // await ref.read(feedControllerProvider.notifier).getData();
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: neutral,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 33.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.w),
                  child: Text(
                    "Daily Feed",
                    style: feedDaily,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: SizedBox(
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
                                        width: 81.w,
                                        height: 36.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // setState(() {
                                            //   for (var element in isSelected) {
                                            //     if (element.keys.first == e.keys.first) {
                                            //       element.update(element.keys.first, (value) => true);
                                            //     } else {
                                            //       element.update(element.keys.first, (value) => false);
                                            //     }
                                            //   }

                                            //   // if (e.keys.first == 'All' ) {
                                            //   //   final filter = productsFilter;
                                            //   //   products.clear();
                                            //   //   products.addAll(filter);
                                            //   // } else {
                                            //   //   final filter = productsFilter
                                            //   //       .where((element) => element.category == e.keys.first.toLowerCase())
                                            //   //       .toList();
                                            //   //   products.clear();
                                            //   //   products.addAll(filter);
                                            //   // }
                                            // });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primary,
                                          ),
                                          child: e.keys.first == 'Donation'
                                              ? Text(
                                                  e.keys.first,
                                                  style: productCategoryWhite.copyWith(fontSize: 10.sp),
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
                                              final filter = feedFilter;
                                              feed.clear();
                                              feed.addAll(filter);
                                            } else if (e.keys.first == 'Donation') {
                                              final filter = feedFilter
                                                  .where(
                                                      (element) => element.type?.toLowerCase() == e.keys.first.toLowerCase())
                                                  .toList();
                                              feed.clear();
                                              feed.addAll(filter);
                                            } else {
                                              final filter = feedFilter
                                                  .where((element) =>
                                                      element.category?.toLowerCase() == e.keys.first.toLowerCase())
                                                  .toList();
                                              feed.clear();
                                              feed.addAll(filter);
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // donation
                  ListView.builder(
                    itemCount: feed.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = feed[index];
                      var donationTarget = item.donationTarget;
                      var donationCurrent = item.donationTotal;
                      var donationPercentage = (((donationCurrent ?? 0) / (donationTarget ?? 0)) * 100).toStringAsFixed(0);

                      return item.type == 'donation'
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FeedDetailScreen(
                                                  feed: item,
                                                )));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
                                    width: 329.w,
                                    decoration:
                                        BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                      buildPrimaryBoxShadow(),
                                    ]),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(100.r),
                                                  child: Image.network(
                                                    // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                                                    item.userphoto.toString(),
                                                    width: 46.w,
                                                    height: 46.h,
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
                                                      // "Jennifer Turner",
                                                      item.username.toString(),
                                                      style: feedPostName,
                                                    ),
                                                    Text(
                                                      DateFormat('dd MMMM yyyy HH:mm')
                                                          .format(DateTime.fromMillisecondsSinceEpoch(item.createdAt!)),
                                                      style: feedPostTime,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Image.asset(
                                                'assets/icons/option-dot-icon.png',
                                                width: 20.w,
                                                height: 20.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(4.r),
                                              child: SizedBox(
                                                width: 87.w,
                                                height: 25.h,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: secondary,
                                                  ),
                                                  child: Text(
                                                    "Donation",
                                                    style: feedDonationSmallBtn,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Flexible(
                                                child: Text(
                                              // "Anjing kurus banget",
                                              item.title.toString(),
                                              style: feedCaption,
                                            )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        if (item.photo != "null" || item.photo != null || item.photo != '')
                                          Image.network(
                                            // "https://img.indonesiatoday.co.id/photos/post/1660446477-anjing-golden-retriever-yang-kurus-dan-tinggal-tulang-menunggu-pemiliknya-yang-telah-meninggalkannya.jpg",
                                            item.photo.toString(),
                                            width: 309.w,
                                            height: 200.h,
                                            fit: BoxFit.cover,
                                          ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Center(
                                          child: LinearPercentIndicator(
                                            padding: EdgeInsets.zero,
                                            barRadius: Radius.circular(6.r),
                                            animation: true,
                                            animationDuration: 1000,
                                            width: 300.w,
                                            lineHeight: 10.h,
                                            percent: (donationCurrent ?? 0) / (donationTarget ?? 0),
                                            progressColor: primary,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Target: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(item.donationTarget)}",
                                              style: feedDonationMoney,
                                            ),
                                            Text(
                                              "$donationPercentage%",
                                              style: feedDonationPercent,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
                                  width: 329.w,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100.r),
                                                child: Image.network(
                                                  // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                                                  item.userphoto.toString(),
                                                  width: 46.w,
                                                  height: 46.h,
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
                                                    // "Jennifer Turner",
                                                    item.username.toString(),
                                                    style: feedPostName,
                                                  ),
                                                  Text(
                                                    // "41m ago",
                                                    DateFormat('dd MMMM yyyy HH:mm')
                                                        .format(DateTime.fromMillisecondsSinceEpoch(item.createdAt!)),
                                                    style: feedPostTime,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Image.asset(
                                              'assets/icons/option-dot-icon.png',
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                          // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dolor, aliquam venenatis loooossss morenos",
                                          item.content.toString(),
                                          style: feedCaption,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      if (item.photo != '')
                                        Image.network(
                                          // "https://cdns.diadona.co.id/diadona.id/resized/640x320/news/2021/11/12/52877/265-nama-kucing-lucu-bikin-gemas-selalu-diingat-dan-ngangenin-211112b.jpg",
                                          item.photo.toString(),
                                          width: 309.w,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                        ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Image.asset(
                                              "assets/icons/love-unselected-icon.png",
                                              width: 25.w,
                                              height: 25.h,
                                            ),
                                          ),
                                          Text(
                                            "${Random().nextInt(100)}",
                                            style: feedCounter,
                                          ),
                                          SizedBox(
                                            width: 32.w,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Image.asset(
                                              "assets/icons/comment-icon.png",
                                              width: 25.w,
                                              height: 25.h,
                                            ),
                                          ),
                                          Text(
                                            "${Random().nextInt(100)}",
                                            style: feedCounter,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            );
                    },
                  ),
                  // // post without image
                  // // post with image
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
                  //   width: 329.w,
                  //   decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  //     buildPrimaryBoxShadow(),
                  //   ]),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               ClipRRect(
                  //                 borderRadius: BorderRadius.circular(100.r),
                  //                 child: Image.network(
                  //                   "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                  //                   width: 46.w,
                  //                   height: 46.h,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 12.w,
                  //               ),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     "Jeremiah K.",
                  //                     style: feedPostName,
                  //                   ),
                  //                   Text(
                  //                     "1h ago",
                  //                     style: feedPostTime,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           IconButton(
                  //             onPressed: () {},
                  //             icon: Image.asset(
                  //               'assets/icons/option-dot-icon.png',
                  //               width: 20.w,
                  //               height: 20.h,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 8.h,
                  //       ),
                  //       Text("Tabby the cat", style: feedCaption, maxLines: 2, overflow: TextOverflow.ellipsis),
                  //       SizedBox(
                  //         height: 8.h,
                  //       ),
                  //       Image.network(
                  //         "https://cdns.diadona.co.id/diadona.id/resized/640x320/news/2021/11/12/52877/265-nama-kucing-lucu-bikin-gemas-selalu-diingat-dan-ngangenin-211112b.jpg",
                  //         width: 309.w,
                  //         height: 200.h,
                  //         fit: BoxFit.cover,
                  //       ),
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           IconButton(
                  //             onPressed: () {},
                  //             icon: Image.asset(
                  //               "assets/icons/love-unselected-icon.png",
                  //               width: 25.w,
                  //               height: 25.h,
                  //             ),
                  //           ),
                  //           Text(
                  //             "22k",
                  //             style: feedCounter,
                  //           ),
                  //           SizedBox(
                  //             width: 32.w,
                  //           ),
                  //           IconButton(
                  //             onPressed: () {},
                  //             icon: Image.asset(
                  //               "assets/icons/comment-icon.png",
                  //               width: 25.w,
                  //               height: 25.h,
                  //             ),
                  //           ),
                  //           Text(
                  //             "1k",
                  //             style: feedCounter,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context, users);
        },
        backgroundColor: primary,
        child: Icon(
          Icons.add,
          color: whitish,
        ),
      ),
    );
  }

  void _showModalBottomSheet(context, Users users) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                decoration: BoxDecoration(color: whitish, boxShadow: [buildSecondaryBoxShadow()]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Jenis Postingan",
                      style: bottomSheetLabel,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: SizedBox(
                            width: 158.w,
                            height: 46.h,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedAddScreen(
                                            isDonation: true,
                                            users: users,
                                          )),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.w,
                                  color: primary,
                                ),
                              ),
                              child: Text(
                                "Donasi",
                                style: productKeranjang,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: SizedBox(
                            width: 158.w,
                            height: 46.h,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedAddScreen(
                                            isDonation: false,
                                            users: users,
                                          )),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              child: Text(
                                "Normal",
                                style: productBuy,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
