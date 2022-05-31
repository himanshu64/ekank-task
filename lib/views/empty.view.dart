import 'package:ekank/viewmodels/empty.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyView extends GetView<EmptyViewModel> {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Empty View'),
      ),
    );
  }
}
