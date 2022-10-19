import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petscape/src/features/home/domain/products/products.dart';
import 'package:petscape/src/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends ConsumerWidget {
  final List<Products> carts;
  const CartScreen({super.key, required this.carts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          padding: const EdgeInsets.all(20.0),
          itemCount: carts.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      carts[index].name.toString(),
                      style: itemTitle,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      carts[index].desc.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: itemSource,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: graySecond,
                          backgroundColor: graySecond,
                        ),
                        child: Text(
                          carts[index].category.toString(),
                          style: articleTag,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
