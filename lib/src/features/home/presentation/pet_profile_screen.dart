import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/home/presentation/edit_pet_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/pet/pet.dart';
import 'package:petscape/src/shared/theme.dart';

class PetProfileScreen extends StatefulWidget {
  final String usersId;
  final Pet pet;
  const PetProfileScreen({Key? key, required this.pet, required this.usersId}) : super(key: key);

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final history = widget.pet.health;

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
                "Pet Details",
                style: appBarTitle,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPetScreen(isEdit: true, pet: widget.pet, usersId: widget.usersId),
                      ));
                },
                icon: Image.asset(
                  "assets/icons/pencil-icon.png",
                  scale: 4,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.network(
                      // "https://www.wikihow.com/images_en/thumb/f/f0/Make-a-Dog-Love-You-Step-6-Version-4.jpg/v4-1200px-Make-a-Dog-Love-You-Step-6-Version-4.jpg",
                      widget.pet.image.toString(),
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  // "Anying",
                  widget.pet.name.toString(),
                  style: petNameBig,
                ),
                Text(
                  // "Anying teranying",
                  'Your Happy ${widget.pet.category}!',
                  style: petNameDesc,
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
            Container(
              width: 1.sw,
              height: 4.h,
              color: HexColor('#EAEAEA'),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:",
                    style: petLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Anying",
                    widget.pet.name.toString(),
                    style: petValue,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    "Breed:",
                    style: petLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Anying Galak",
                    widget.pet.breed ?? "",
                    style: petValue,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    "Sex:",
                    style: petLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Gay",
                    widget.pet.sex ?? '',
                    style: petValue,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    "Condition:",
                    style: petLabel,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    // "Sekarat - 1 ton",
                    widget.pet.condition == null || widget.pet.weight == null
                        ? ''
                        : '${widget.pet.condition} - ${widget.pet.weight} kg',
                    style: petValue,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            ),
            Container(
              width: 1.sw,
              height: 4.h,
              color: HexColor('#EAEAEA'),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health History",
                    style: petHealth,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ListView.builder(
                      itemCount: history?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 16.w, top: 15.h, right: 8.w, bottom: 15.h),
                                width: 324.w,
                                height: 96.h,
                                decoration:
                                    BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                  buildPrimaryBoxShadow(),
                                ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // "12 July 2022",
                                          // DateFormat('dd MMMM yyyy')
                                          //     .format(DateTime.parse(history![index]['time'].toString())),
                                          DateFormat('dd MMMM yyyy').format(
                                              DateTime.fromMillisecondsSinceEpoch(int.tryParse(history![index]['time'])!)),
                                          style: petDatePrimary,
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          // "Daily Check July 2022",
                                          'Daily Check ${DateFormat('MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(history[index]['time'])!))}',
                                          style: petDateBlack,
                                        ),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            // "Lorem ipsum dolor sit amet, consectetur lorem lorem lorem",
                                            history[index]['desc'].toString(),
                                            style: petDateDesc,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      "assets/icons/arrow-right-gray-icon.png",
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
