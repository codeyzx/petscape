import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/vets_add_screen.dart';
import 'package:petscape/src/features/vets/presentation/vets_controller.dart';
import 'package:petscape/src/features/vets/presentation/vets_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class VetsAllScreen extends ConsumerStatefulWidget {
  final String usersId;
  const VetsAllScreen({Key? key, required this.usersId}) : super(key: key);

  @override
  ConsumerState<VetsAllScreen> createState() => _VetsAllScreenState();
}

class _VetsAllScreenState extends ConsumerState<VetsAllScreen> {
  List<Map<String, bool>> isSelected = [
    {'All': true},
    {'Dog': false},
    {'Cat': false},
    {'Others': false},
  ];
  List<Vets> vets = [];
  List<Vets> vetsFilter = [];

  @override
  void initState() {
    super.initState();
    initVets();
  }

  Future<void> initVets() async {
    await ref.read(vetsControllerProvider.notifier).getData();
    final returnVets = ref.read(vetsControllerProvider);
    setState(() {
      vets.addAll(returnVets);
      vetsFilter.addAll(returnVets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
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
                "Vets",
                style: appBarTitle,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VetsAddScreen()));
                },
                icon: Image.asset("assets/icons/date-icon.png", scale: 4),
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
              SizedBox(
                height: 24.h,
              ),
              Container(
                width: 324.w,
                height: 154.h,
                padding: EdgeInsets.only(left: 145.w, top: 20.h, bottom: 4.h, right: 18.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: secondary,
                    image:
                        const DecorationImage(image: AssetImage('assets/images/petscape/vet-bg-img.png'), fit: BoxFit.cover),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        HexColor('#FD9884'),
                        HexColor('#D03415'),
                      ],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured Vets",
                      style: vetFeatured,
                    ),
                    SizedBox(
                      width: 161.w,
                      height: 30.h,
                      child: Text(
                        "Dr. Gracie Trisha",
                        style: vetNameBigWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Cat Diseases Specialist",
                      style: vetDescFeatured,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      width: 154.w,
                      height: 32.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(whitish),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 21.w, vertical: 4.h),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/chat-icon.png',
                              width: 18.w,
                              height: 18.h,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              "Consule Now",
                              style: vetBlackOnButton,
                            ),
                          ],
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
                                            final filter = vetsFilter;
                                            vets.clear();
                                            vets.addAll(filter);
                                          } else {
                                            final filter = vetsFilter
                                                .where((element) =>
                                                    element.category?.toLowerCase() == e.keys.first.toLowerCase())
                                                .toList();
                                            vets.clear();
                                            vets.addAll(filter);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primary,
                                      ),
                                      child:
                                          // e.keys.first == 'Others'
                                          //     ? Text(
                                          //         e.keys.first,
                                          //         style: productCategoryBlack,
                                          //       )
                                          // :
                                          Text(
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
                                          final filter = vetsFilter;
                                          vets.clear();
                                          vets.addAll(filter);
                                        } else {
                                          final filter = vetsFilter
                                              .where(
                                                  (element) => element.category?.toLowerCase() == e.keys.first.toLowerCase())
                                              .toList();
                                          vets.clear();
                                          vets.addAll(filter);
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
                "Explore The Vets",
                style: homeCategoryTitle,
              ),
              SizedBox(
                height: 12.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 192.h, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w, crossAxisCount: 2),
                itemCount: vets.length,
                itemBuilder: (context, index) => SizedBox(
                  width: 154.w,
                  height: 192.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VetsDetailScreen(usersId: widget.usersId, vets: vets[index])),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 154.w,
                      height: 192.h,
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
                              // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                              vets[index].image.toString(),
                              width: 154.w,
                              height: 120.h,
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
                                    // "Dr. Naegha Blak",
                                    vets[index].name.toString(),
                                    style: vetAllTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  // "Cat Specialist",
                                  vets[index].degree.toString(),
                                  style: vetAllDesc,
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
                                      // "4.5",
                                      vets[index].rate.toString(),
                                      style: vetAllRating,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Container(
                                      width: 1.w,
                                      height: 10.h,
                                      color: black.withOpacity(0.60),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      // "Bandung",
                                      vets[index].location.toString(),
                                      style: vetAllRating,
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
    );
  }
}
