import 'package:ekank/helpers/enums.dart';
import 'package:ekank/helpers/exceptions.dart';
import 'package:ekank/services/firebase/auth.service.dart';
import 'package:ekank/viewmodels/base.viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = Get.find<AuthService>();

  void signInWithGoogle() async {
    setState(ViewState.busy);

    try {
      User? user = await _authService.signInWithGoogle();
      print("user $user");
      setState(ViewState.idle);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'sign_in_canceled') {
        Fluttertoast.showToast(
            msg: "Sign in cancelled by user!",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      }
      if (e.code == 'account-exists-with-different-credential') {
        Fluttertoast.showToast(
            msg: "The account already exists with a different credential",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      } else if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(
            msg: "Error occurred while accessing credentials. Try again.",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      }
      setState(ViewState.idle);
    } on CancelledByUser catch (e) {
      setState(ViewState.idle);
      Fluttertoast.showToast(
          msg: "$e", toastLength: Toast.LENGTH_LONG, fontSize: 16);
    } on PlatformException catch (e) {
      setState(ViewState.idle);
      if (e.code == "network_error") {
        Fluttertoast.showToast(
            msg: 'No Internet Connection',
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      } else if (e.code == "sign_in_failed") {
        Fluttertoast.showToast(
            msg: 'Sign in failed!',
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16);
      }
    } catch (e) {
      print(e);
      setState(ViewState.idle);
      Fluttertoast.showToast(
          msg: 'Error occurred using Google Sign In. Try again.',
          toastLength: Toast.LENGTH_LONG,
          fontSize: 16);
    }
  }
}
