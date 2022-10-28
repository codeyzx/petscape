import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/feed/domain/feed.dart';
import 'package:petscape/src/features/feed/presentation/feed_controller.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:image/image.dart' as image_reduce;

class FeedAddScreen extends ConsumerStatefulWidget {
  final Users users;
  final bool isDonation;
  const FeedAddScreen({Key? key, required this.users, required this.isDonation}) : super(key: key);

  @override
  ConsumerState<FeedAddScreen> createState() => _FeedAddScreenState();
}

class _FeedAddScreenState extends ConsumerState<FeedAddScreen> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _donationTarget = TextEditingController();
  final _accountBank = TextEditingController();
  final _content = TextEditingController();

  String _image = '';
  String _typeBank = '';
  String _category = '';

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _description.dispose();
    _donationTarget.dispose();
    _accountBank.dispose();
    _content.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: neutral,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
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
                  "Postingan Donasi",
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
              child: widget.isDonation
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              'Foto',
                              style: textTitleBookmark,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            GestureDetector(
                              onTap: () async {
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

                                                final temp = await FirebaseStorage.instance
                                                    .ref()
                                                    .child('feed/${DateTime.now()}.png')
                                                    .putFile(File(compressedImage.path));
                                                final value = await temp.ref.getDownloadURL();

                                                setState(() {
                                                  _image = value;
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

                                                final temp = await FirebaseStorage.instance
                                                    .ref()
                                                    .child('products/${DateTime.now()}.png')
                                                    .putFile(File(compressedImage.path));
                                                final value = await temp.ref.getDownloadURL();
                                                setState(() {
                                                  _image = value;
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
                                  : _image == ''
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
                                                _image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Judul",
                              style: vetBookInputLabel,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 328.w,
                                  height: 42.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
                                TextFormField(
                                  controller: _title,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harap isi judul';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: homeSearchText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "lorem ipsum",
                                      hintStyle: homeSearchHint,
                                      contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi",
                              style: vetBookInputLabel,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 328.w,
                                  height: 42.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 328.w,
                                    height: 42.h,
                                    child: TextFormField(
                                      controller: _description,
                                      keyboardType: TextInputType.text,
                                      style: homeSearchText,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "lorem ipsum",
                                          hintStyle: homeSearchHint,
                                          contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kategori",
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
                                    ),
                                    value: _category == '' ? null : _category,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Harap isi kategori';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      "Pilih Kategori",
                                      style: vetBookDropdownInput,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      _category = value.toString();
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Target Donasi",
                              style: vetBookInputLabel,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 328.w,
                                  height: 42.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
                                TextFormField(
                                  controller: _donationTarget,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harap isi target donasi';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  style: homeSearchText,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Rp000",
                                    hintStyle: homeSearchHint,
                                    contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank",
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
                                        value: 'bca',
                                        child: Text('Bca'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'bri',
                                        child: Text('Bri'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'permata',
                                        child: Text('Permata'),
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
                                    ),
                                    value: _typeBank == '' ? null : _typeBank,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Harap isi bank';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      "Pilih Bank",
                                      style: vetBookDropdownInput,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      _typeBank = value.toString();
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor Rekening",
                              style: vetBookInputLabel,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 328.w,
                                  height: 42.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
                                TextFormField(
                                  controller: _accountBank,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harap isi nomor rekening';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  style: homeSearchText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "lorem ipsum",
                                      hintStyle: homeSearchHint,
                                      contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              'Foto',
                              style: textTitleBookmark,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            GestureDetector(
                              onTap: () async {
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

                                                final temp = await FirebaseStorage.instance
                                                    .ref()
                                                    .child('feed/${DateTime.now()}.png')
                                                    .putFile(File(compressedImage.path));
                                                final value = await temp.ref.getDownloadURL();

                                                setState(() {
                                                  _image = value;
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

                                                final temp = await FirebaseStorage.instance
                                                    .ref()
                                                    .child('products/${DateTime.now()}.png')
                                                    .putFile(File(compressedImage.path));
                                                final value = await temp.ref.getDownloadURL();
                                                setState(() {
                                                  _image = value;
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
                                  : _image == ''
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
                                                _image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Konten",
                              style: vetBookInputLabel,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  width: 328.w,
                                  height: 42.h,
                                  decoration:
                                      BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                                    buildPrimaryBoxShadow(),
                                  ]),
                                ),
                                TextFormField(
                                  controller: _content,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Harap isi konten';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: homeSearchText,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "lorem ipsum",
                                      hintStyle: homeSearchHint,
                                      contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kategori",
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
                                    ),
                                    value: _category == '' ? null : _category,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Harap isi kategori';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      "Pilih Kategori",
                                      style: vetBookDropdownInput,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      _category = value.toString();
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
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
                  if (widget.isDonation) {
                    if (_formKey.currentState!.validate() && _image != '') {
                      final feed = Feed(
                        type: 'donation',
                        userId: widget.users.uid,
                        username: widget.users.name,
                        userphoto: widget.users.photoUrl,
                        photo: _image,
                        title: _title.text,
                        description: _description.text,
                        category: _category,
                        donationTarget: int.parse(_donationTarget.text),
                        typeBank: _typeBank,
                        accountBank: _accountBank.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      );
                      await ref.read(feedControllerProvider.notifier).add(feed);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Berhasil menambahkan postingan'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const BotNavBarScreen(),
                                          ));
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Harap isi semua form'),
                        ),
                      );
                    }
                  } else {
                    if (_formKey.currentState!.validate()) {
                      final feed = Feed(
                        type: 'normal',
                        userId: widget.users.uid,
                        username: widget.users.name,
                        userphoto: widget.users.photoUrl,
                        photo: _image,
                        content: _content.text,
                        category: _category,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      );
                      await ref.read(feedControllerProvider.notifier).add(feed);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Berhasil menambahkan postingan'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const BotNavBarScreen(),
                                          ));
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                ),
                child: Text(
                  "Post",
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
