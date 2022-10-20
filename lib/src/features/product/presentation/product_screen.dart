import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';
import 'package:petscape/src/features/home/presentation/products_controller.dart';
import 'package:petscape/src/features/product/domain/product/product.dart';
import 'package:petscape/src/features/product/presentation/product_add_screen.dart';
import 'package:petscape/src/features/product/presentation/product_detail_screen.dart';
import 'package:petscape/src/shared/theme.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static const routeName = '/product';
  const ProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  final List<bool> _isSelected = [true, false, false, false];
  List<Product> cages = [];
  List<Product> cagesFilter = [];

  @override
  void initState() {
    super.initState();
    initCages();
  }

  Future<void> initCages() async {
    final returnCages = ref.read(productsControllerProvider);
    setState(() {
      cages.addAll(returnCages);
      cagesFilter.addAll(returnCages);
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: HexColor('EBEDEE'),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            iconColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            labelText: "Search by Username",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              tooltip: 'Add Cages',
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductAddScreen(),
                    ));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const CagesAddScreen(isEdit: false),
                //     ));
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'All',
                          style: _isSelected[0] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[0],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[0] == false) {
                              _isSelected[0] = true;
                              _isSelected[1] = false;
                              _isSelected[2] = false;
                              _isSelected[3] = false;

                              cages.clear();
                              cages.addAll(cagesFilter);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Drugs',
                          style: _isSelected[1] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[1],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[1] == false) {
                              _isSelected[1] = true;
                              _isSelected[0] = false;
                              _isSelected[2] = false;
                              _isSelected[3] = false;

                              final koloni = cagesFilter.where((element) => element.category == 'drugs').toList();
                              cages.clear();
                              cages.addAll(koloni);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Outfit',
                          style: _isSelected[2] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[2],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[2] == false) {
                              _isSelected[2] = true;
                              _isSelected[0] = false;
                              _isSelected[1] = false;
                              _isSelected[3] = false;

                              final solo = cagesFilter.where((element) => element.category == 'outfit').toList();
                              cages.clear();
                              cages.addAll(solo);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      ChoiceChip(
                        selectedColor: primary,
                        labelPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 24.w),
                        label: Text(
                          'Others',
                          style: _isSelected[3] ? chipSelected : chipUnSelected,
                        ),
                        selected: _isSelected[3],
                        onSelected: (newBoolValue) {
                          setState(() {
                            if (_isSelected[3] == false) {
                              _isSelected[3] = true;
                              _isSelected[0] = false;
                              _isSelected[1] = false;
                              _isSelected[2] = false;

                              final ip = cagesFilter.where((element) => element.category == 'test').toList();
                              cages.clear();
                              cages.addAll(ip);
                            }
                            // articles.clear();
                            // articles.addAll(article);
                          });
                        },
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300, mainAxisSpacing: 10, crossAxisSpacing: 5, crossAxisCount: 2),
              itemCount: cages.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          cagesFromScan: cages[index],
                        ),
                      ));
                  // await FirebaseFirestore.instance.collection("carts").doc(users.uid).update({
                  //   'userId': users.uid,
                  //   "items": FieldValue.arrayUnion([
                  //     {
                  //       'id': cages[index].id,
                  //       'qty': 1,
                  //     }
                  //   ])
                  // });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                // cages[index].images.toString(),
                                //random image
                                'https://picsum.photos/250?image=9',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cages[index].name.toString().toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Rp ${cages[index].price}',
                                style: GoogleFonts.poppins(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'category: ${cages[index].category}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
