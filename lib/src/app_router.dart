import 'package:go_router/go_router.dart';
import 'package:petscape/src/features/auth/presentation/sign_in_screen.dart';
import 'package:petscape/src/features/auth/presentation/sign_up_screen.dart';
import 'package:petscape/src/features/feed/presentation/feed_screen.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:petscape/src/features/home/presentation/home_screen.dart';
import 'package:petscape/src/features/order/presentation/order_screen.dart';
import 'package:petscape/src/features/profile/presentation/profile_screen.dart';
import 'package:petscape/src/features/starter/presentation/onboarding_screen.dart';
import 'package:petscape/src/features/starter/presentation/splash_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/', name: SplashScreen.routeName, builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', name: OnBoardingScreen.routeName, builder: (context, state) => const OnBoardingScreen()),
    GoRoute(path: '/sign-in', name: SignInScreen.routeName, builder: (context, state) => const SignInScreen()),
    GoRoute(path: '/sign-up', name: SignUpScreen.routeName, builder: (context, state) => const SignUpScreen()),
    GoRoute(path: '/botnavbar', name: BotNavBarScreen.routeName, builder: (context, state) => const BotNavBarScreen()),
    GoRoute(path: '/home', name: HomeScreen.routeName, builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/order', name: OrderScreen.routeName, builder: (context, state) => const OrderScreen()),
    GoRoute(path: '/profile', name: ProfileScreen.routeName, builder: (context, state) => const ProfileScreen()),
    GoRoute(path: '/feed', name: FeedScreen.routeName, builder: (context, state) => const FeedScreen()),
  ],
);
