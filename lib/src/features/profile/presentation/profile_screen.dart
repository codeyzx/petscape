import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/auth/presentation/sign_in_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const routeName = 'profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: whitish,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 34.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.network(
                            // 'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1510033690/xtys6miadoejvaigkxf7.jpg',
                            users.photoUrl ??
                                'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1510033690/xtys6miadoejvaigkxf7.jpg',
                            width: 64.w,
                            height: 64.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 225.w,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        // 'John Doe',
                                        users.name ?? '',
                                        style: profileName2)),
                              ),
                            ),
                            SizedBox(
                              width: 225.w,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        // "useremailjanganlupa@gmail.com",
                                        users.email ?? '',
                                        style: profileEmail2)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 1.sw,
                height: 4.h,
                color: HexColor('#EAEAEA'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Akun",
                      style: profileItemLabel,
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/edit-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ubah Profile",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/paw-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Peliharaanmu",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Bantuan",
                      style: profileItemLabel,
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/contact-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Kontak",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/report-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Laporkan Masalah",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Lainnya",
                      style: profileItemLabel,
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/star-black-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Beri Rating",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/order-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ketentuan Layanan",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/shield-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Kebijakan Privasi",
                                      style: profileItemName,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () async {
                        try {
                          context.goNamed(SignInScreen.routeName);
                          ref.read(authControllerProvider.notifier).googleSignOut();
                        } catch (e) {
                          // snackbar error
                          showDialog(
                            context: context,
                            builder: (context) => SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/icons/logout-icon.png",
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 288.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Keluar",
                                      style: profileItemNamePrimary,
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-primary-icon.png",
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  width: 288.w,
                                  height: 1.h,
                                  color: HexColor('#E5E5E5'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
      // child: Scaffold(
      //   backgroundColor: Colors.white,
      //   body: SingleChildScrollView(
      //     physics: const AlwaysScrollableScrollPhysics(),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12.w),
      //           width: 1.sw,
      //           height: 72.h,
      //           decoration: BoxDecoration(
      //             color: HexColor('#F2FEFF'),
      //           ),
      //           child: Padding(
      //             padding: EdgeInsets.only(top: 20.h, left: 12.w),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Profile',
      //                   style: appBarTitle,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 16.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 12.w),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   ClipRRect(
      //                     borderRadius: BorderRadius.circular(100.r),
      //                     child: Image.network(
      //                       // 'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1510033690/xtys6miadoejvaigkxf7.jpg',
      //                       users.photoUrl ??
      //                           'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1510033690/xtys6miadoejvaigkxf7.jpg',
      //                       width: 54.w,
      //                       height: 54.h,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     width: 12.w,
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         // 'John Doe',
      //                         users.name ?? '',
      //                         style: profileName,
      //                       ),
      //                       // Text(
      //                       //   'Member since 2021',
      //                       //   style: profileEmail,
      //                       // ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               Text(
      //                 'Account',
      //                 style: profileItemTitle,
      //               ),
      //               SizedBox(
      //                 height: 18.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/pencil-icon.png',
      //                               width: 17.w,
      //                               height: 17.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Change profile',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/bell-icon.png',
      //                               width: 20.w,
      //                               height: 19.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Reminder & Notification',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 32.h,
      //               ),
      //               Text(
      //                 'General',
      //                 style: profileItemTitle,
      //               ),
      //               SizedBox(
      //                 height: 18.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/help-icon.png',
      //                               width: 18.w,
      //                               height: 18.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Help',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/feedback-icon.png',
      //                               width: 24.w,
      //                               height: 24.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Feedback',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/share-black-big-icon.png',
      //                               width: 19.w,
      //                               height: 19.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Share With Friends',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               InkWell(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/star-icon.png',
      //                               width: 15.w,
      //                               height: 15.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Rate Us',
      //                               style: profileItemSubTitle,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 24.h,
      //               ),
      //               InkWell(
      //                 onTap: () async {
      //                   try {
      //                     context.goNamed(SignInScreen.routeName);
      //                     ref.read(authControllerProvider.notifier).googleSignOut();
      //                   } catch (e) {
      //                     // snackbar error
      //                     showDialog(
      //                       context: context,
      //                       builder: (context) => SnackBar(content: Text('Error: ${e.toString()}')),
      //                     );
      //                   }
      //                 },
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Image.asset(
      //                               'assets/images/logout-icon.png',
      //                               width: 18.w,
      //                               height: 18.h,
      //                             ),
      //                             SizedBox(
      //                               width: 12.w,
      //                             ),
      //                             Text(
      //                               'Logout',
      //                               style: logoutTxt,
      //                             ),
      //                           ],
      //                         ),
      //                         Icon(
      //                           Icons.keyboard_arrow_right_rounded,
      //                           color: HexColor('#606060'),
      //                         ),
      //                       ],
      //                     ),
      //                     Container(
      //                       margin: EdgeInsets.only(left: 34.w, top: 16.h),
      //                       width: 300.w,
      //                       height: 1.h,
      //                       color: HexColor('#E5E5E5'),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
