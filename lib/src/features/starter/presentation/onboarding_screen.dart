import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:petscape/src/features/auth/presentation/sign_in_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitish,
      body: Container(
        padding: EdgeInsets.only(bottom: 150.h),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 91.67.h,),
                Image.asset("assets/images/petscape/onboard-1-img.png", width: 289.09.w, height: 202.65.h,),
                SizedBox(height: 55.67.h,),
                Text(
                  'Save articles with ease',
                  style: onBoardTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 256.w,
                    child: Text(
                      'Semua keperluan hewanmu ada disini',
                      style: onBoardSubTitle,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64.25.h,),
                Image.asset("assets/images/petscape/onboard-2-img.png", width: 289.09.w, height: 202.65.h,),
                SizedBox(height: 55.67.h,),
                Text(
                  'Temukan Dokter Hewanmu',
                  style: onBoardTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 256.w,
                    child: Text(
                      'Janjian maupun chat dengan dokter hewan sekarang',
                      style: onBoardSubTitle,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64.25.h,),
                Image.asset("assets/images/petscape/onboard-3-img.png", width: 289.09.w, height: 202.65.h,),
                SizedBox(height: 55.67.h,),
                Text(
                  'Beli Kebutuhan Cepat',
                  style: onBoardTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    width: 256.w,
                    child: Text(
                      'Dari makanan hingga mainan hewanmu ada disini',
                      style: onBoardSubTitle,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 150.h,
        width: 1.sw,
        color: whitish,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 10.w,
                dotHeight: 12.h,
                dotWidth: 12.w,
                type: WormType.normal,
                dotColor: gray,
                activeDotColor: primary,
              ),
            ),
            SizedBox(height: 54.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 329.w,
                height: 48.h,
                child: TextButton(
                  onPressed: () {
                    context.goNamed(SignInScreen.routeName);
                  },
                  child: Text(
                    'Mulai',
                    style: onBoardWhiteOnBtn,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(primary)),
                ),
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 150.h,
        width: 1.sw,
        color: whitish,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 10.w,
                dotHeight: 12.h,
                dotWidth: 12.w,
                type: WormType.normal,
                dotColor: gray,
                activeDotColor: primary,
              ),
            ),
            SizedBox(height: 51.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 121.w,
                  height: 40.h,
                  child: TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text(
                      'Lewati',
                      style: onBoardSkipBtn,
                    ),
                  ),
                ),
                SizedBox(
                  width: 121.w,
                  height: 40.h,
                  child: TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      'Lanjut',
                      style: onBoardWhiteOnBtnSmall,
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(primary)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
