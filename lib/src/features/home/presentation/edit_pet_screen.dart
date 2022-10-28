import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/features/order/domain/pet/pet.dart';
import 'package:petscape/src/features/order/presentation/pet_controller.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:image/image.dart' as image_reduce;

class EditPetScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final String usersId;
  final Pet? pet;
  const EditPetScreen({Key? key, required this.isEdit, this.pet, required this.usersId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditPetScreenState();
}

class EditPetScreenState extends ConsumerState<EditPetScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _sexController = TextEditingController();
  final _weightController = TextEditingController();
  final _conditionController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _nameController.text = widget.pet!.name ?? '';
      _breedController.text = widget.pet!.breed ?? '';
      _sexController.text = widget.pet!.sex ?? '';
      _conditionController.text = widget.pet!.condition ?? '';
      _weightController.text = widget.pet!.weight.toString() == 'null' ? '' : widget.pet!.weight.toString();
      _imageController.text = widget.pet!.image ?? '';
      _categoryController.text = widget.pet!.category ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _breedController.dispose();
    _sexController.dispose();
    _weightController.dispose();
    _imageController.dispose();
    _conditionController.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                "${widget.isEdit ? 'Edit' : 'Add'} Pet",
                style: appBarTitle,
              ),
              SizedBox(
                width: 30.w,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Photo',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        //show dialog to choose pick from image or camera
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Choose Image',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      Navigator.pop(context);
                                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        final tempDir = await getTemporaryDirectory();
                                        final path = tempDir.path;
                                        image_reduce.Image image =
                                            image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
                                        image_reduce.copyResize(image, width: 500);
                                        final compressedImage = File('$path/img_$image.jpg')
                                          ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

                                        final value = await ref
                                            .read(petControllerProvider.notifier)
                                            .uploadImages(compressedImage.path);

                                        setState(() {
                                          _imageController.text = value;
                                          _isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.image,
                                            ),
                                          ),
                                          TextSpan(
                                              text: '  From Gallery',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      Navigator.pop(context);
                                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                                      if (pickedFile != null) {
                                        final tempDir = await getTemporaryDirectory();
                                        final path = tempDir.path;
                                        image_reduce.Image image =
                                            image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
                                        image_reduce.copyResize(image, width: 500);
                                        final compressedImage = File('$path/img_$image.jpg')
                                          ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

                                        final value = await ref
                                            .read(petControllerProvider.notifier)
                                            .uploadImages(compressedImage.path);
                                        setState(() {
                                          _imageController.text = value;
                                          _isLoading = false;
                                        });
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.camera_alt,
                                            ),
                                          ),
                                          TextSpan(
                                              text: '  From Camera',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: _isLoading
                          ? Container(
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(color: gray),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : _imageController.text == ''
                              ? Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: gray),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        _imageController.text,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                    ),
                    // FutureBuilder(

                    //   future: _imageController.text == ''
                    //       ? Future.value('https://picsum.photos/500/300?random=1')
                    //       : Future.value(_imageController.text),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       return GestureDetector(
                    //         onTap: () async {
                    //           final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    //           if (pickedFile != null) {
                    //             final image = File(pickedFile.path);
                    //             final fileName = basename(image.path);
                    //             final destination = 'images/$fileName';
                    //             final storage = FirebaseStorage.instance;
                    //             final task = storage.ref(destination).putFile(image);
                    //             final snapshot = await task.whenComplete(() {});
                    //             final url = await snapshot.ref.getDownloadURL();
                    //             setState(() {
                    //               _imageController.text = url;
                    //             });
                    //           }
                    //         },
                    //         child: Container(
                    //           height: 200.h,
                    //           width: double.infinity,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(6.r),
                    //             image: DecorationImage(
                    //               image: NetworkImage(snapshot.data.toString()),
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     } else {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //   },
                    // ),

                    // TextFormField(
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   controller: _imageController,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(6.r),
                    //       borderSide: BorderSide(width: 1, color: graySecond),
                    //     ),
                    //     contentPadding: const EdgeInsets.all(12),
                    //     hintText: 'https://',
                    //     hintStyle: tagHint,
                    //     suffixIcon: IconButton(
                    //       onPressed: () async {
                    //         // upload image to firebase storage
                    //         // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    //         // if (pickedFile != null) {
                    //         //   final file = File(pickedFile.path);
                    //         //   final fileName = basename(file.path);
                    //         //   final destination = 'images/$fileName';
                    //         //   final ref = FirebaseStorage.instance.ref(destination);
                    //         //   await ref.putFile(file);
                    //         //   final url = await ref.getDownloadURL();
                    //         //   _imageController.text = url;
                    //         // }
                    //       },
                    //       icon: const Icon(Icons.image),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          width: 1.sw,
                          height: 45.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          style: homeSearchText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Zowy",
                              hintStyle: homeSearchHint.copyWith(color: Colors.black.withOpacity(0.4)),
                              contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select category';
                            }
                            return null;
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'Cat',
                              child: Text('Cat'),
                            ),
                            DropdownMenuItem(
                              value: 'Dog',
                              child: Text('Dog'),
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
                          value: _categoryController.text == '' ? null : _categoryController.text,
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
                            // _experiencePet = value.toString();
                            _categoryController.text = value.toString();
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Breed",
                      style: vetBookInputLabel,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 45.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                        ),
                        TextFormField(
                          controller: _breedController,
                          style: homeSearchText,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Pitbull",
                              hintStyle: homeSearchHint.copyWith(color: Colors.black.withOpacity(0.4)),
                              contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sex",
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
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
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
                          value: _sexController.text == '' ? null : _sexController.text,
                          hint: Text(
                            "Select Sex",
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
                            // _experiencePet = value.toString();
                            _sexController.text = value.toString();
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Condition",
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
                              value: 'Normal',
                              child: Text('Normal'),
                            ),
                            DropdownMenuItem(
                              value: 'Sick',
                              child: Text('Sick'),
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
                          value: _conditionController.text == '' ? null : _conditionController.text,
                          hint: Text(
                            "Select Condition",
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
                            _conditionController.text = value.toString();
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weight",
                      style: vetBookInputLabel,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 1.sw,
                          height: 45.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                        ),
                        TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          style: homeSearchText,
                          decoration: InputDecoration(
                              // add suffix icon with text KG
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "KG",
                                  style: vetBookInputLabel,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: "8",
                              hintStyle: homeSearchHint.copyWith(color: Colors.black.withOpacity(0.4)),
                              contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.isEdit) {
                    final Pet pet = widget.pet!.copyWith(
                      name: _nameController.text,
                      breed: _breedController.text,
                      category: _categoryController.text,
                      sex: _sexController.text,
                      condition: _conditionController.text,
                      weight: int.tryParse(_weightController.text),
                      image: _imageController.text == ''
                          ? _categoryController.text == 'Cat'
                              ? 'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fcat-default.jpg?alt=media&token=9b8cda7d-8b55-45cc-8a67-03a9983a5cbe'
                              : 'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fdog-default.jpg?alt=media&token=4b22797b-696f-4de2-8489-e6182fa170f1'
                          : _imageController.text,
                    );
                    await ref.read(petControllerProvider.notifier).update(pet: pet);
                    await ref.read(petControllerProvider.notifier).getData(widget.usersId);
                    // show dialog
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Pet updated successfully'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const BotNavBarScreen(),
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    final Pet pet = Pet(
                      name: _nameController.text,
                      breed: _breedController.text,
                      category: _categoryController.text,
                      sex: _sexController.text,
                      condition: _conditionController.text,
                      weight: int.tryParse(_weightController.text),
                      image: _imageController.text == ''
                          ? _categoryController.text == 'Cat'
                              ? 'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fcat-default.jpg?alt=media&token=9b8cda7d-8b55-45cc-8a67-03a9983a5cbe'
                              : 'https://firebasestorage.googleapis.com/v0/b/petscape-799a5.appspot.com/o/pet%2Fdog-default.jpg?alt=media&token=4b22797b-696f-4de2-8489-e6182fa170f1'
                          : _imageController.text,
                    );
                    await ref.read(petControllerProvider.notifier).add(pet: pet, usersId: widget.usersId.toString());
                    await ref.read(petControllerProvider.notifier).getData(widget.usersId);
                    // show dialog
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Pet added successfully'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const BotNavBarScreen(),
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              child: Text(
                widget.isEdit ? 'Update' : 'Add',
                style: vetBookOnBtnWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
