import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petscape/src/features/feed/domain/feed.dart';
import 'package:petscape/src/features/home/widgets/box_shadow.dart';
import 'package:petscape/src/shared/theme.dart';

class FeedDonationScreen extends StatefulWidget {
  final Feed feed;
  const FeedDonationScreen({Key? key, required this.feed}) : super(key: key);

  @override
  State<FeedDonationScreen> createState() => _FeedDonationScreenState();
}

class _FeedDonationScreenState extends State<FeedDonationScreen> {
  bool isEnabled = true;
  final textController = TextEditingController();
  List<Map<int, bool>> isSelected = [
    {10000: false},
    {20000: false},
    {50000: false},
    {100000: false},
  ];

  int amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: neutral,
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
                "Donasi",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: 328.w,
                decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                  buildPrimaryBoxShadow(),
                ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      // "https://img.indonesiatoday.co.id/photos/post/1660446477-anjing-golden-retriever-yang-kurus-dan-tinggal-tulang-menunggu-pemiliknya-yang-telah-meninggalkannya.jpg",
                      widget.feed.photo.toString(),
                      width: 80.w,
                      height: 64.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                        child: Text(
                      // "Anjing terlantar di dekat pasar, kekurangan gizi",
                      widget.feed.title.toString(),
                      style: feedCaption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                "Pilih Jumlah",
                style: feedDonationLabel,
              ),
              SizedBox(
                height: 10.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 54.h, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w, crossAxisCount: 2),
                itemCount: isSelected.length,
                itemBuilder: (context, index) => isSelected[index].values.first
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            for (var element in isSelected) {
                              amount = 0;
                              isEnabled = true;
                              element.update(element.keys.first, (value) => false);
                              textController.text = '';
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: primary,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 159.w,
                          height: 54.h,
                          decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                          child: Center(
                              child: Text(
                            // "Rp 10.000",
                            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                .format(isSelected[index].keys.first),
                            style: feedDonationMoneyItem.copyWith(color: whitish),
                          )),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            for (var element in isSelected) {
                              if (element.keys.first == isSelected[index].keys.first) {
                                element.update(element.keys.first, (value) => true);
                                amount = isSelected[index].keys.first;
                                isEnabled = false;
                                textController.text = '';
                              } else {
                                element.update(element.keys.first, (value) => false);
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 159.w,
                          height: 54.h,
                          decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                            buildPrimaryBoxShadow(),
                          ]),
                          child: Center(
                              child: Text(
                            // "Rp 10.000",
                            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                .format(isSelected[index].keys.first),
                            style: feedDonationMoneyItem,
                          )),
                        ),
                      ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 132.w,
                    height: 1.h,
                    color: black.withOpacity(0.15),
                  ),
                  Text(
                    "atau",
                    style: homeSearchHint,
                  ),
                  Container(
                    width: 132.w,
                    height: 1.h,
                    color: black.withOpacity(0.15),
                  ),
                ],
              ),
              SizedBox(
                height: 11.h,
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    width: 328.w,
                    height: 52.h,
                    decoration: BoxDecoration(color: whitish, borderRadius: BorderRadius.circular(4.r), boxShadow: [
                      buildPrimaryBoxShadow(),
                    ]),
                  ),
                  Center(
                    child: TextFormField(
                      enabled: isEnabled,
                      controller: textController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLines: 3,
                      style: homeSearchText,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Jumlah",
                          hintStyle: homeSearchHint,
                          contentPadding: EdgeInsets.only(left: 11.w, top: 11.h, bottom: 10.h)),
                    ),
                  ),
                ],
              ),
            ],
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
                if (isEnabled) {
                  if (textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Harap isi jumlah donasi'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    amount = int.parse(textController.text);
                    print(amount);
                  }
                } else {
                  // amount = amount;
                  print(amount);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
              ),
              child: Text(
                "Konfirmasi & Bayar",
                style: vetBookOnBtnWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
