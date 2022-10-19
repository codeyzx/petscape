import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:petscape/src/app_router.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/auth/presentation/auth_controller.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  String? changes;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final users = ref.read(authControllerProvider);

    final isBg = state == AppLifecycleState.paused;
    final isClosed = state == AppLifecycleState.detached;
    final isScreen = state == AppLifecycleState.resumed;

    Logger().e('masuk');

    if (users != const Users()) {
      Logger().e('masuk');
      if (isScreen) {
        Logger().e('isBg: $isBg ONLINE');
        FirebaseFirestore.instance.collection('users').doc(users.uid).update({'status': "Online"});
      } else {
        Logger().e('isBg: $isBg OFFLINE');
        FirebaseFirestore.instance.collection('users').doc(users.uid).update({'status': ""});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'petscape',
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      },
    );
  }
}
