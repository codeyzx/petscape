import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/shared/theme.dart';

class ProductAddScreen extends ConsumerStatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends ConsumerState<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
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
                    'seller': _sellerController.text,
                    'image': _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
                    'stock': int.tryParse(_stockController.text),
                    'sold': int.tryParse(_soldController.text),
                    'price': int.tryParse(_priceController.text),
                    'desc': _descController.text,
                    'location': _locationController.text,
                  });
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'category *',
                //       style: textTitleBookmark,
                //     ),
                //     SizedBox(
                //       height: 6.h,
                //     ),
                //     DropdownButtonFormField(
                //         validator: (value) {
                //           if (value == null || value.isEmpty) {
                //             return 'Please enter category';
                //           }
                //           return null;
                //         },
                //         items: const [
                //           DropdownMenuItem(
                //             value: 'koloni',
                //             child: Text('koloni'),
                //           ),
                //           DropdownMenuItem(
                //             value: 'solo',
                //             child: Text('solo'),
                //           ),
                //           DropdownMenuItem(
                //             value: 'ip',
                //             child: Text('ip'),
                //           ),
                //         ],
                //         value: _categoryController.text,
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(6.r),
                //             borderSide: BorderSide(width: 1, color: graySecond),
                //           ),
                //           contentPadding: const EdgeInsets.all(12),
                //           hintStyle: tagHint,
                //         ),
                //         onChanged: (value) {
                //           _categoryController.text = value.toString();
                //         }),
                //     SizedBox(
                //       height: 18.h,
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'image',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _imageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: graySecond),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'https://',
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
                          borderSide: BorderSide(width: 1, color: graySecond),
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
