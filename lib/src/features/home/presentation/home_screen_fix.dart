import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/home/presentation/products_controller.dart';
import 'package:petscape/src/features/home/presentation/shop_service_all_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';
import 'package:petscape/src/shared/theme.dart';

class HomeScreenFix extends ConsumerStatefulWidget {
  static const routeName = 'home-fix';
  const HomeScreenFix({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreenFix> createState() => _HomeScreenFixState();
}

class _HomeScreenFixState extends ConsumerState<HomeScreenFix> {
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
    setState(() {
      products.addAll(returnProducts);
      productsFilter.addAll(returnProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: neutral,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 280.w,
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
                                  hintText: "Search Something",
                                  hintStyle: homeSearchHint,
                                  contentPadding: EdgeInsets.only(left: 13.w, top: 4.h, bottom: 7.h)),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Image.asset(
                              "assets/icons/bell-icon.png",
                              width: 24.w,
                              height: 24.h,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 9.w, top: 19.h, bottom: 16.h),
                      width: 324.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(4.r),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/petscape/dog-paws-bg.png'),
                          scale: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Consult My Pet",
                            style: homeWhiteTitle,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "Konsultasikan segala masalah\nhewanmu segera.",
                            style: homeWhiteSubTitle,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          SizedBox(
                            width: 166.w,
                            height: 30.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(whitish),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                ),
                              ),
                              child: Text(
                                "Konsultasi Sekarang",
                                style: homeBlackButton,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Your Pet",
                      style: homeCategoryTitle,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      height: 64.h,
                      child: ListView.builder(
                          itemCount: 5,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: InkWell(
                                onTap: () {
                                  //change page to pet profile
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.network(
                                    "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                                    width: 64.w,
                                    height: 64.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 64.w,
                        height: 64.h,
                        decoration: BoxDecoration(color: whitish, shape: BoxShape.circle, boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/add-round-icon.png',
                            width: 28.w,
                            height: 28.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Shop & Services",
                          style: homeCategoryTitle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopServiceAll(
                                        usersId: users.uid.toString(),
                                      )),
                            );
                          },
                          child: Text(
                            "See All",
                            style: homeAllButton,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            //change page to food
                          },
                          child: SizedBox(
                            width: 60.w,
                            height: 86.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/dog-food-icon.png',
                                      width: 35.w,
                                      height: 35.h,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Foods",
                                  style: homeShopItemTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //change page to toys
                          },
                          child: SizedBox(
                            width: 60.w,
                            height: 86.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/bone-icon.png',
                                      width: 35.w,
                                      height: 35.h,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Toys",
                                  style: homeShopItemTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //change page to vets medicine
                          },
                          child: SizedBox(
                            width: 60.w,
                            height: 86.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/pill-icon.png',
                                      width: 35.w,
                                      height: 35.h,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Medicine",
                                  style: homeShopItemTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //change page to vets treatment
                          },
                          child: SizedBox(
                            width: 60.w,
                            height: 86.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/scissor-icon.png',
                                      width: 35.w,
                                      height: 35.h,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Treatment",
                                  style: homeShopItemTreatmentTitlee,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "Vets Recommendation",
                      style: homeCategoryTitle,
                    ),
                    ListView.builder(
                        itemCount: products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Visibility(
                            visible: index < 4,
                            child: InkWell(
                              onTap: () {
                                //change page to vets profile
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                width: 324.w,
                                height: 85.h,
                                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 8.w, right: 12.w),
                                decoration:
                                    BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                  buildPrimaryBoxShadow(),
                                ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(4.r),
                                          child: Image.network(
                                            // "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg",
                                            products[index].image.toString(),
                                            width: 54.w,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 13.w,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // "Dr. Naegha Blak",
                                              products[index].name.toString(),
                                              style: homeDoctorName,
                                            ),
                                            Text(
                                              // "Afrika Serikat",
                                              products[index].location.toString(),
                                              style: homeDoctorAddress,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/icons/rating-icon.png",
                                                  width: 18.w,
                                                  height: 18.h,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  "4.5",
                                                  style: homeRatingNum,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/icons/right-arrow-icon.png',
                                      width: 15.w,
                                      height: 15.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
