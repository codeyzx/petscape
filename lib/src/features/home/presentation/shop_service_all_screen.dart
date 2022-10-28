import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/product/presentation/product_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class ShopServiceAll extends StatefulWidget {
  final Users users;
  const ShopServiceAll({Key? key, required this.users}) : super(key: key);

  @override
  State<ShopServiceAll> createState() => _ShopServiceAllState();
}

class _ShopServiceAllState extends State<ShopServiceAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: AppBar(
          primary: true,
          backgroundColor: whitish,
          elevation: 4,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("assets/icons/arrow-left-icon.png"),
          ),
          title: Text(
            "Shop & Services",
            style: appBarTitle,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(
                            type: 'food',
                            users: widget.users,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
              child: Container(
                width: 324.w,
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [buildPrimaryBoxShadow()]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: HexColor('#FFF4DC'),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/dog-food-icon.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Food",
                          style: shsvallItemTitle,
                        ),
                        Text(
                          "Find food for your pet",
                          style: shsvallItemSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              type: 'toys',
                              users: widget.users,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
              child: Container(
                width: 324.w,
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [buildPrimaryBoxShadow()]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: HexColor('#DCE8FF'),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/bone-icon.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Toys",
                          style: shsvallItemTitle,
                        ),
                        Text(
                          "Make your pet happy with toy",
                          style: shsvallItemSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              type: 'medicine',
                              users: widget.users,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
              child: Container(
                width: 324.w,
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [buildPrimaryBoxShadow()]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: HexColor('#FFE2DC'),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/pill-icon.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Medicine",
                          style: shsvallItemTitle,
                        ),
                        Text(
                          "Buy medicine from nearest shop",
                          style: shsvallItemSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              type: 'treatment',
                              users: widget.users,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
              child: Container(
                width: 324.w,
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [buildPrimaryBoxShadow()]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: HexColor('#DDFFDC'),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/scissor-icon.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Treatment",
                          style: shsvallItemTitle,
                        ),
                        Text(
                          "Get the best treatment for your pet",
                          style: shsvallItemSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              type: 'accessories',
                              users: widget.users,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
              child: Container(
                width: 324.w,
                height: 72.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [buildPrimaryBoxShadow()]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: HexColor('#FADCFF'),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/icons/accessories-icon.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Accessories",
                          style: shsvallItemTitle,
                        ),
                        Text(
                          "Cool pets, Cool owner.",
                          style: shsvallItemSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
