import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petscape/src/shared/theme.dart';

import 'package:image/image.dart' as image_reduce;

class ProductAddScreen extends ConsumerStatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends ConsumerState<ProductAddScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();
  final _sellerController = TextEditingController();
  final _imageController = TextEditingController();
  final _soldController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _stockController = TextEditingController();
  final List<String> listGliders = [];

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    _sellerController.dispose();
    _imageController.dispose();
    _soldController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _stockController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/x-icon.png',
            width: 12.w,
            height: 12.h,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: false,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/x-icon.png',
                      width: 12.w,
                      height: 12.h,
                    ),
                  ),
                ),
                Text(
                  'Add',
                  style: btmsheet,
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final db = FirebaseFirestore.instance.collection("products").doc();
                  await db.set({
                    'id': db.id,
                    'name': _nameController.text,
                    'category': _categoryController.text,
                    'type': _typeController.text,
                    'seller': _sellerController.text,
                    'image': _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
                    'stock': int.tryParse(_stockController.text),
                    'sold': int.tryParse(_soldController.text),
                    'price': int.tryParse(_priceController.text),
                    'desc': _descController.text,
                    'location': _locationController.text,
                  });
                  _nameController.clear();
                  _categoryController.clear();
                  _typeController.clear();
                  _sellerController.clear();
                  _imageController.clear();
                  _soldController.clear();
                  _priceController.clear();
                  _descController.clear();
                  _locationController.clear();
                  _stockController.clear();
                }
              },
              child: Text(
                'Save',
                style: txtBtnBlue,
              ),
            ),
          ],
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
                                            .child('products/${DateTime.now()}.png')
                                            .putFile(File(compressedImage.path));
                                        final value = await temp.ref.getDownloadURL();

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

                                        final temp = await FirebaseStorage.instance
                                            .ref()
                                            .child('products/${DateTime.now()}.png')
                                            .putFile(File(compressedImage.path));
                                        final value = await temp.ref.getDownloadURL();
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
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'type *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter type';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _typeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'food',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'Chicken Nugget',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'category',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _categoryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'category',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'seller',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _sellerController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'seller',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'location',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'location',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'desc',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _descController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'desc',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'price',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'price',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'stock',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      controller: _stockController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'stock',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sold',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      controller: _soldController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'sold',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
