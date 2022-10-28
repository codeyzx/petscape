import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/chat/presentation/chat_screen.dart';
import 'package:petscape/src/features/home/presentation/edit_pet_screen.dart';
import 'package:petscape/src/features/home/presentation/pet_profile_screen.dart';
import 'package:petscape/src/features/order/presentation/pet_controller.dart';
import 'package:petscape/src/features/product/presentation/product_controller.dart';
import 'package:petscape/src/features/home/presentation/shop_service_all_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/domain/product.dart';
import 'package:petscape/src/features/product/presentation/product_screen.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/vets_all_screen.dart';
import 'package:petscape/src/features/vets/presentation/vets_controller.dart';
import 'package:petscape/src/features/vets/presentation/vets_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = false;

  List<Product> products = [];
  List<Product> productsFilter = [];
  List<Vets> vets = [];

  @override
  void initState() {
    super.initState();
    initProducts();
  }

  Future<void> initProducts() async {
    setState(() {
      isLoading = true;
    });

    final usersId = ref.read(authControllerProvider).uid;
    await ref.read(productControllerProvider.notifier).getData();
    await ref.read(vetsControllerProvider.notifier).getData();
    await ref.read(petControllerProvider.notifier).getData(usersId.toString());
    final returnProducts = ref.read(productControllerProvider);
    final returnVets = ref.read(vetsControllerProvider);

    setState(() {
      products.addAll(returnProducts);
      productsFilter.addAll(returnProducts);
      vets.addAll(returnVets);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    final pet = ref.watch(petControllerProvider);

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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()));
                            },
                            child: Image.asset(
                              "assets/icons/chat-black-icon.png",
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
                      height: 100.h,
                      child: !isLoading
                          ? ListView.builder(
                              itemCount: pet.length,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: InkWell(
                                    onTap: () {
                                      //change page to pet profile
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PetProfileScreen(pet: pet[index], usersId: users.uid.toString()),
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(100.r),
                                          child: Image.network(
                                            // "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                                            pet[index].image.toString(),
                                            width: 64.w,
                                            height: 64.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          pet[index].name.toString(),
                                          style: petTitle,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : ListView.builder(
                              itemCount: 2,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(100.r),
                                            child: Container(
                                              width: 64.w,
                                              height: 64.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.r),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Container(
                                            width: 64.w,
                                            height: 16.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: InkWell(
                        onTap: () async {
                          //change page to add pet
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPetScreen(isEdit: false, usersId: users.uid.toString()),
                              ));
                        },
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
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
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
                                        users: users,
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

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                          type: 'food',
                                          users: users,
                                        )));
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

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                          type: 'toys',
                                          users: users,
                                        )));
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

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                          type: 'medicine',
                                          users: users,
                                        )));
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
                            //change page

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                          type: 'treatment',
                                          users: users,
                                        )));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Vets Recommendation",
                          style: homeCategoryTitle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VetsAllScreen(usersId: users.uid.toString())),
                            );
                          },
                          child: Text(
                            "See All",
                            style: homeAllButton,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: !isLoading ? vets.length : 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return !isLoading
                            ? Visibility(
                                visible: index < 4,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VetsDetailScreen(
                                                vets: vets[index],
                                                usersId: users.uid.toString(),
                                              )),
                                    );
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
                                                vets[index].image.toString(),
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
                                                  vets[index].name.toString(),
                                                  style: homeDoctorName,
                                                ),
                                                Text(
                                                  // "Afrika Serikat",
                                                  vets[index].location.toString(),
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
                                                      vets[index].rate.toString(),
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
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  width: 324.w,
                                  height: 85.h,
                                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 8.w, right: 12.w),
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
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
