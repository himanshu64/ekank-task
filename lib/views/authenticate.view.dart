import 'package:ekank/viewmodels/auth.viewmodel.dart';
import 'package:ekank/views/home/home.view.dart';
import 'package:ekank/views/login/login.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticateView extends GetView<AuthViewModel> {
  static const routeName = '/';
  const AuthenticateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.authStatus,
        builder: (context, snapshot) {
          return snapshot.hasData ? HomeView() : const LoginView();
        });
  }
}
