import 'dart:developer';

import 'package:ekank/helpers/enums.dart';
import 'package:ekank/helpers/internet_connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        log("[AppState] init mobile modules ..");

        MyConnectivity.instance.initialise();
        MyConnectivity.instance.myStream.listen((onData) {
          log("[App] internet issue change: $onData");

          if (MyConnectivity.instance.isIssue(onData)) {
            if (MyConnectivity.instance.isShow == false) {
              MyConnectivity.instance.isShow = true;
              Get.dialog(CupertinoAlertDialog(
                title: Center(
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.warning,
                      ),
                      Text("No Internet Connection"),
                    ],
                  ),
                ),
                content: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Please check you internet connection"),
                ),
              )).then((onValue) {
                MyConnectivity.instance.isShow = false;
                log("[showDialogNotInternet] dialog closed $onValue");
              });
            }
          } else {
            if (MyConnectivity.instance.isShow == true) {
              // Navigator.of(context).pop();
              MyConnectivity.instance.isShow = false;
            }
          }
        });

        // FirebaseCloudMessagagingWapper()
        //   ..init()
        //   ..delegate = this;

        // OneSignalWapper()..init();
        log("[AppState] register modules .. DONE");
      },
    );

    super.onInit();
  }

  final _state = ViewState.idle.obs;

  ViewState get state => _state.value;

  void setState(ViewState viewState) {
    _state.value = viewState;
  }
}
