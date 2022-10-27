import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/vets/domain/vets.dart';
import 'package:petscape/src/features/vets/presentation/vets_controller.dart';
import 'package:petscape/src/shared/theme.dart';

class VetsAddScreen extends ConsumerStatefulWidget {
  const VetsAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VetsAddScreenState();
}

class _VetsAddScreenState extends ConsumerState<VetsAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _nameController = TextEditingController();
  final _degreeController = TextEditingController();
  final _addressController = TextEditingController();
  final _patientController = TextEditingController();
  final _experienceController = TextEditingController();
  final _rateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _workTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
    _nameController.dispose();
    _degreeController.dispose();
    _addressController.dispose();
    _patientController.dispose();
    _experienceController.dispose();
    _rateController.dispose();
    _categoryController.dispose();
    _workTimeController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _phoneController.dispose();
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
                  final vets = Vets(
                    image: _imageController.text == '' ? 'https://picsum.photos/500/300?random=1' : _imageController.text,
                    name: _nameController.text,
                    degree: _degreeController.text,
                    address: _addressController.text,
                    patient: int.parse(_patientController.text),
                    experience: int.parse(_experienceController.text),
                    rate: double.parse(_rateController.text),
                    category: _categoryController.text,
                    workTime: _workTimeController.text,
                    location: _locationController.text,
                    price: int.parse(_priceController.text),
                    desc: _descController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                  );
                  await ref.read(vetsControllerProvider.notifier).add(vets);
                  print('masuk');
                  print(vets);
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
                // generate form field by all controller
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'degree *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter degree';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _degreeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'S1',
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
                      'address *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'Jl. Raya Cibubur',
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
                      'phone *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'email *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'description *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _descController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'category *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter category';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _categoryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'price *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'image *',
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
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
                      'location *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                // work time controller
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'work time *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter work time';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _workTimeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                // patient controller
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'patient *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter patient';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _patientController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                // rate controller
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'rate *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter rate';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _rateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
                        hintStyle: tagHint,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
                // experience controller
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'experience *',
                      style: textTitleBookmark,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter experience';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _experienceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          borderSide: BorderSide(width: 1, color: gray),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: '08123456789',
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
