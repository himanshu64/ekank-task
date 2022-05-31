import 'package:ekank/viewmodels/auth.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOutWidget extends GetView<AuthViewModel> {
  const SignOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          controller.signOut();
        },
        icon: const Icon(Icons.logout));
  }
}
