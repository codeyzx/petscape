// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:petscape/src/features/product/domain/product/product.dart';
// import 'package:petscape/src/shared/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CartScreen extends ConsumerWidget {
//   final List<Map<Product, int>> items;
//   const CartScreen({super.key, required this.items});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final List<Product> product = items.map((e) => e.keys.first).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//       ),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1,
//         ),
//         padding: const EdgeInsets.all(20.0),
//         itemCount: product.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () async {},
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 100.w,
//                   child: Text(
//                     product[index].name.toString(),
//                     style: itemTitle,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6.h,
//                 ),
//                 SizedBox(
//                   width: 200,
//                   child: Text(
//                     product[index].desc.toString(),
//                     maxLines: 2,
//                     overflow: TextOverflow.fade,
//                     style: itemSource,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 12.h,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {},
//                       style: TextButton.styleFrom(
//                         foregroundColor: gray,
//                         backgroundColor: gray,
//                       ),
//                       child: Text(
//                         items[index].values.first.toString(),
//                         style: articleTag,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
