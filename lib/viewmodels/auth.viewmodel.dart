import 'package:ekank/helpers/enums.dart';

import 'package:ekank/services/firebase/auth.service.dart';
import 'package:ekank/viewmodels/base.viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService _authService = Get.find<AuthService>();
  Stream<User?> get authStatus => _authService.authStatus;

  void signOut() async {
    try {
      setState(ViewState.busy);
      await _authService.signOut();
      setState(ViewState.idle);
    } catch (e) {
      setState(ViewState.idle);
    }
  }
}
