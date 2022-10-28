import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petscape/src/features/feed/presentation/feed_screen.dart';
import 'package:petscape/src/features/home/presentation/home_screen.dart';
import 'package:petscape/src/features/order/presentation/order_screen.dart';
import 'package:petscape/src/features/profile/presentation/profile_screen.dart';
import 'package:petscape/src/shared/theme.dart';

final currentScreenProvider = StateProvider<Widget>((ref) => const HomeScreen());
final currentIndexProvider = StateProvider<int>((ref) => 0);

class BotNavBarScreen extends ConsumerStatefulWidget {
  const BotNavBarScreen({Key? key}) : super(key: key);
  static const routeName = 'botnavbar';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BotNavBarScreenState();
}

class _BotNavBarScreenState extends ConsumerState<BotNavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(currentScreenProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: whitish,
          fixedColor: primary,
          selectedLabelStyle: botNavSelected,
          unselectedLabelStyle: botNavUnSelected,
          type: BottomNavigationBarType.fixed,
          iconSize: 20.0.sp,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              ref.read(currentIndexProvider.state).state = index;
              switch (index) {
                case 0:
                  ref.read(currentScreenProvider.state).state = const HomeScreen();
                  break;
                case 1:
                  ref.read(currentScreenProvider.state).state = const FeedScreen();
                  break;
                case 2:
                  ref.read(currentScreenProvider.state).state = const OrderScreen();
                  break;
                case 3:
                  ref.read(currentScreenProvider.state).state = const ProfileScreen();
                  break;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: const Icon(Icons.home_filled),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: const Icon(Icons.pets),
                ),
                label: 'Feed'),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: const Icon(Icons.list_alt_rounded),
              ),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: const Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
