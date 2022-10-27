import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation//vets_booking_three_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';

class VetsBookingTwoScreen extends ConsumerStatefulWidget {
  final Map<String, String> timePlace;
  final Vets vets;

  const VetsBookingTwoScreen({Key? key, required this.timePlace, required this.vets}) : super(key: key);

  @override
  ConsumerState<VetsBookingTwoScreen> createState() => _VetsBookingTwoScreenState();
}

class _VetsBookingTwoScreenState extends ConsumerState<VetsBookingTwoScreen> {
  String _experiencePet = "";
  String usersId = "";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fillForm();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  void fillForm() {
    final users = ref.read(authControllerProvider);
    _nameController.text = users.name.toString();
    _emailController.text = users.email.toString();
    usersId = users.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  "Booking Appointment",
                  style: appBarTitle,
                ),
                Container(
                  width: 29.w,
                  height: 29.h,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Personal Information",
                    style: vetBookTitle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Step 2/4",
                    style: vetBookPart,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Name",
                    style: vetBookInputLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 324.w,
                        height: 45.h,
                        decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                      ),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        style: homeSearchText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Your Name",
                            hintStyle: homeSearchHint,
                            contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Email Address",
                    style: vetBookInputLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 324.w,
                        height: 45.h,
                        decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: homeSearchText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "User@gmail.com",
                            hintStyle: homeSearchHint,
                            contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Phone Number",
                    style: vetBookInputLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 324.w,
                        height: 45.h,
                        decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                          buildPrimaryBoxShadow(),
                        ]),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        style: homeSearchText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // icon prefix with text +62
                            prefixIcon: Container(
                              // width: 10.w,
                              // height: 10.h,
                              margin: EdgeInsets.only(bottom: 3.h),
                              padding: EdgeInsets.only(top: 3.h),

                              width: 50.w,
                              decoration: BoxDecoration(
                                color: whitish,
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                              ),
                              child: Center(
                                child: Text(
                                  "+62",
                                  style: homeSearchText,
                                ),
                              ),
                            ),
                            hintText: "856xxx",
                            hintStyle: homeSearchHint,
                            contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Experience with pet",
                    style: vetBookInputLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  PhysicalModel(
                    color: Colors.transparent,
                    elevation: 3,
                    shadowColor: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.r),
                    child: DropdownButtonFormField(
                        items: const [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('<1 Years'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('>1 Years'),
                          ),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          // hintStyle: ,
                        ),
                        value: null,
                        hint: Text(
                          "Select Years",
                          style: vetBookDropdownInput,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // decoration: InputDecoration(
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(4.r),
                        //   ),
                        //   contentPadding: const EdgeInsets.all(12),
                        // ),
                        onChanged: (value) {
                          _experiencePet = value.toString();
                        }),
                  ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  //   width: 324.w,
                  //   height: 42.h,
                  //   decoration: BoxDecoration(
                  //     color: whitish,
                  //     borderRadius: BorderRadius.circular(4.r),
                  //     boxShadow: [
                  //       buildPrimaryBoxShadow(),
                  //     ],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Select Years",
                  //         style: vetBookDropdownInput,
                  //       ),
                  //       Image.asset(
                  //         "assets/icons/arrow-down-icon.png",
                  //         width: 18.w,
                  //         height: 18.h,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
          width: 1.sw,
          height: 72.h,
          decoration: BoxDecoration(color: whitish, boxShadow: [
            buildSecondaryBoxShadow(),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: 324.w,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final address = {
                      "name": _nameController.text,
                      "email": _emailController.text,
                      "phone": _phoneController.text,
                      "experience": _experiencePet,
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VetsBookingThreeScreen(
                                vets: widget.vets,
                                usersId: usersId,
                                address: address,
                                timePlace: widget.timePlace,
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                ),
                child: Text(
                  "Continue",
                  style: vetBookOnBtnWhite,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
