import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/order/domain/pet/pet.dart';
import 'package:petscape/src/features/order/presentation/pet_controller.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/vets_booking_four_screen.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';

class VetsBookingThreeScreen extends ConsumerStatefulWidget {
  final Map<String, String> address;
  final Map<String, String> timePlace;
  final Users users;
  final Vets vets;

  const VetsBookingThreeScreen(
      {Key? key, required this.address, required this.timePlace, required this.users, required this.vets})
      : super(key: key);

  @override
  ConsumerState<VetsBookingThreeScreen> createState() => _VetsBookingThreeScreenState();
}

class _VetsBookingThreeScreenState extends ConsumerState<VetsBookingThreeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _detailController = TextEditingController();

  String _category = '';
  String _image = '';
  String _years = '';
  String _id = '';

  List<Map<String, bool>> problemOptions = [
    {'Flu': false},
    {'Infection': false},
    {'Itchy': false},
    {'Allergie': false},
    {'Urinary': false},
    {'Other': false},
  ];

  List<String> problems = [];

  @override
  Widget build(BuildContext context) {
    final pet = ref.read(petControllerProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: neutral,
        resizeToAvoidBottomInset: true,
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
          child: Column(
            children: [
              Padding(
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
                        "Pet Information",
                        style: vetBookTitle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Step 3/4",
                        style: vetBookPart,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Select pet",
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
                            items: pet
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      // child: Text(e.name.toString()),
                                      // text with image
                                      child: Row(
                                        children: [
                                          // image network circular
                                          Container(
                                            width: 40.w,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(e.image.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(e.name.toString()),
                                        ],
                                      ),
                                    ))
                                .toList(),
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
                              "Select Your Pet",
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
                              setState(() {
                                _id = value!.id.toString();
                                _nameController.text = value.name.toString();
                                _category = value.category.toString();
                                _image = value.image.toString();
                              });
                            }),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Pet Name *",
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
                            decoration: BoxDecoration(
                              color: whitish,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                buildPrimaryBoxShadow(),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            style: homeSearchText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter pet name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Your pet name",
                                hintStyle: homeSearchHint,
                                contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Category *",
                        style: vetBookInputLabel,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                            width: 324.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: whitish,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                buildPrimaryBoxShadow(),
                                buildPrimaryBoxShadow(),
                              ],
                            ),
                          ),
                          DropdownButtonFormField(
                              items: const [
                                DropdownMenuItem(
                                  value: 'Dog',
                                  child: Text('Dog'),
                                ),
                                DropdownMenuItem(
                                  value: 'Cat',
                                  child: Text('Cat'),
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
                              value: _category == '' ? null : _category,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select category';
                                }
                                return null;
                              },
                              hint: Text(
                                "Select Category",
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
                                _category = value.toString();
                              }),
                        ],
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
                      //         "Select Category",
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

                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Years Together",
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
                              _years = value.toString();
                            }),
                      ),

                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Possible Problem * ",
                            style: vetBookInputLabel,
                          ),
                          Text(
                            "(can select more than 1)",
                            style: vetBookInputLabelSmall,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: problemOptions.map((e) {
                      return e.values.first
                          ? Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: SizedBox(
                                width: 84.w,
                                height: 33.h,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      for (var element in problemOptions) {
                                        if (element.keys.first == e.keys.first) {
                                          element.update(element.keys.first, (value) => false);
                                          problems.remove(e.keys.first);
                                        }
                                      }
                                    });
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(primary),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.r),
                                        ),
                                      )),
                                  child: Text(
                                    // "Flu",
                                    e.keys.first,
                                    style: vetBookOnPrimaryChip,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    for (var element in problemOptions) {
                                      if (element.keys.first == e.keys.first) {
                                        element.update(element.keys.first, (value) => true);
                                        problems.add(e.keys.first);
                                      }
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    backgroundColor: MaterialStateProperty.all(whitish),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.r),
                                      ),
                                    )),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                                  width: 84.w,
                                  height: 33.h,
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whitish, boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                  child: Text(
                                    // "Itchy",
                                    e.keys.first,
                                    style: vetBookOnWhiteChip,
                                  ),
                                ),
                              ),
                            );
                    }).toList(),
                    // children: [

                    //   SizedBox(
                    //     width: 18.w,
                    //   ),
                    //   SizedBox(
                    //     width: 69.w,
                    //     height: 33.h,
                    //     child: TextButton(
                    //       onPressed: () {},
                    //       style: ButtonStyle(
                    //           backgroundColor: MaterialStateProperty.all(primary),
                    //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(24.r),
                    //             ),
                    //           )),
                    //       child: Text(
                    //         "Flu",
                    //         style: vetBookOnPrimaryChip,
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 12.w,
                    //   ),
                    //   SizedBox(
                    //     width: 111.w,
                    //     height: 33.h,
                    //     child: TextButton(
                    //       onPressed: () {},
                    //       style: ButtonStyle(
                    //           backgroundColor: MaterialStateProperty.all(primary),
                    //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(24.r),
                    //             ),
                    //           )),
                    //       child: Text(
                    //         "Infection",
                    //         style: vetBookOnPrimaryChip,
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 12.w,
                    //   ),
                    //   TextButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(EdgeInsets.zero),
                    //         backgroundColor: MaterialStateProperty.all(whitish),
                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(24.r),
                    //           ),
                    //         )),
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                    //       width: 84.w,
                    //       height: 33.h,
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whitish, boxShadow: [
                    //         buildPrimaryBoxShadow(),
                    //       ]),
                    //       child: Text(
                    //         "Itchy",
                    //         style: vetBookOnWhiteChip,
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 12.w,
                    //   ),
                    //   TextButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(EdgeInsets.zero),
                    //         backgroundColor: MaterialStateProperty.all(whitish),
                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(24.r),
                    //           ),
                    //         )),
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                    //       width: 110.w,
                    //       height: 33.h,
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whitish, boxShadow: [
                    //         buildPrimaryBoxShadow(),
                    //       ]),
                    //       child: Center(
                    //         child: Text(
                    //           "Allergies",
                    //           style: vetBookOnWhiteChip,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 12.w,
                    //   ),
                    //   TextButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(EdgeInsets.zero),
                    //         backgroundColor: MaterialStateProperty.all(whitish),
                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(24.r),
                    //           ),
                    //         )),
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                    //       width: 101.w,
                    //       height: 33.h,
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whitish, boxShadow: [
                    //         buildPrimaryBoxShadow(),
                    //       ]),
                    //       child: Text(
                    //         "Urinary",
                    //         style: vetBookOnWhiteChip,
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 12.w,
                    //   ),
                    //   TextButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(EdgeInsets.zero),
                    //         backgroundColor: MaterialStateProperty.all(whitish),
                    //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(24.r),
                    //           ),
                    //         )),
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                    //       width: 88.w,
                    //       height: 33.h,
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whitish, boxShadow: [
                    //         buildPrimaryBoxShadow(),
                    //       ]),
                    //       child: Text(
                    //         "Other",
                    //         style: vetBookOnWhiteChip,
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     width: 18.w,
                    //   ),
                    // ],
                  ),
                ),
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
                      "Detail",
                      style: vetBookInputLabel,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 324.w,
                      height: 89.h,
                      decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                        buildPrimaryBoxShadow(),
                      ]),
                      child: Center(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(68),
                          ],
                          controller: _detailController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          style: homeSearchText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Input detail here",
                              hintStyle: homeSearchHint,
                              contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 110.h,
              ),
            ],
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
                  if (_formKey.currentState!.validate() && problems.isNotEmpty) {
                    if (_image == '') {
                      if (_category == 'Dog') {
                        _image =
                            'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fdog-default.jpg?alt=media&token=4b22797b-696f-4de2-8489-e6182fa170f1';
                      } else {
                        _image =
                            'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fcat-default.jpg?alt=media&token=9b8cda7d-8b55-45cc-8a67-03a9983a5cbe';
                      }
                    }
                    final petz = Pet(
                      id: _id,
                      image: _image,
                      name: _nameController.text,
                      category: _category,
                      usersId: widget.users.uid,
                    );
                    final appointment = {
                      "yearsTogether": _years,
                      "possibleProblem": problems,
                      "detail": _detailController.text,
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VetsBookingFourScreen(
                                appointment: appointment,
                                pet: petz,
                                address: widget.address,
                                timePlace: widget.timePlace,
                                users: widget.users,
                                vets: widget.vets,
                              )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all the field'),
                      ),
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
