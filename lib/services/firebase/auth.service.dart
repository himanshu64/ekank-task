import 'package:ekank/helpers/exceptions.dart';
import 'package:ekank/services/base.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends BaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStatus => _auth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user!;
      } catch (e) {
        rethrow;
      }
      //tezdir-patjoh-9coHny
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          user = userCredential.user!;
        } catch (e) {
          rethrow;
        }
      } else {
        throw CancelledByUser("Sign in Cancelled by user");
      }
      return user;
    }
  }

  Future<bool> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
