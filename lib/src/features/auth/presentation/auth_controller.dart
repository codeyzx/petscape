import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:petscape/src/features/auth/domain/users.dart';
import 'package:petscape/src/features/home/presentation/botnavbar_screen.dart';
import 'package:go_router/go_router.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      await googleSignIn.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        var checkUsers = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
        if (!checkUsers.exists) {
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'name': userCredential.user!.displayName,
            'email': userCredential.user!.email,
            'photoUrl': userCredential.user!.photoURL,
            'roles': 'user',
            'status': '',
          });
          await FirebaseFirestore.instance.collection('carts').doc(userCredential.user!.uid).set({
            "users": userCredential.user!.uid,
            "items": [],
          });

          final users = Users(
            uid: userCredential.user!.uid,
            name: userCredential.user!.displayName,
            email: userCredential.user!.email,
            photoUrl: userCredential.user!.photoURL,
            roles: 'user',
          );
          state = users;
        } else {
          final users = Users.fromJson(checkUsers.data()!);
          state = users;
        }
        if (!mounted) return;
        context.goNamed(BotNavBarScreen.routeName);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> googleSignOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    state = Users();
  }

  Future<void> getUsers({required String uid}) async {
    var checkUsers = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final users = Users.fromJson(checkUsers.data()!);
    state = users;
  }

  Future<String> checkUsers() async {
    final result = FirebaseAuth.instance.currentUser;
    Logger().i(result);
    if (result != null) {
      await getUsers(uid: result.uid);
      return result.uid;
    }
    return '';
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
