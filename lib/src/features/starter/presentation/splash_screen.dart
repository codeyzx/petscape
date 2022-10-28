import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/auth/presentation/sign_in_screen.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/starter/presentation/onboarding_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = 'splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitish,
      body: Stack(
        children: [
          Positioned(
            top: 200.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 127.w),
              child: Image.asset("assets/images/petscape/petscape-logo-img.png", width: 104.55.w, height: 150.h,),
            ),
          ),
          Positioned(
            bottom: 34.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 155.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("By", style: splashBy,),
                  Text("ORBIT", style: splashOrbit,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkLogin() async {
    final users = await ref.read(authControllerProvider.notifier).checkUsers();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('onboard');

    if (!mounted) return;
    if (counter == null) {
      await prefs.setInt('onboard', 1);
      Future.delayed(const Duration(seconds: 2), () {
        context.goNamed(OnBoardingScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (users != '') {
          context.goNamed(BotNavBarScreen.routeName);
        } else {
          context.goNamed(SignInScreen.routeName);
        }
      });
    }
  }
}
