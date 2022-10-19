import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/auth/presentation/sign_up_screen.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeName = 'sign-in';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 20.h, left: 18.w, right: 20.w),
                width: 1.sw,
                height: 514.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    )),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: logTitle,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: logInput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(width: 1, color: graySecond),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          hintText: 'Email',
                          hintStyle: emailHint,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: logInput,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.r),
                            borderSide: BorderSide(width: 1, color: graySecond),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          hintText: 'Password',
                          hintStyle: emailHint,
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: SizedBox(
                          width: 320.w,
                          height: 48.h,
                          child: TextButton(
                            onPressed: () async {
                              context.goNamed(BotNavBarScreen.routeName);
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primary)),
                            child: Text(
                              'Masuk',
                              style: txtBtnWhite,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password?',
                            style: txtBtnBlue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 130.w,
                            height: 1.h,
                            color: HexColor('#A6A6A6'),
                          ),
                          Text(
                            'Or',
                            style: orTxt,
                          ),
                          Container(
                            width: 130.w,
                            height: 1.h,
                            color: HexColor('#A6A6A6'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: OutlinedButton(
                          onPressed: () async {
                            try {
                              await ref.read(authControllerProvider.notifier).googleSignIn();
                              if (mounted) {
                                context.goNamed(BotNavBarScreen.routeName);
                              }
                            } catch (e) {
                              Logger().e(e);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r))),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon-google.png',
                                width: 28.w,
                                height: 28.h,
                              ),
                              SizedBox(
                                width: 53.w,
                              ),
                              Text(
                                'Continue with Google',
                                style: googleTxt,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: dontTxt,
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(SignUpScreen.routeName);
                              },
                              child: Text(
                                'Register',
                                style: txtBtnBlue,
                              ),
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
        ],
      ),
    );
  }
}
