import 'package:ekank/helpers/bindings/main_binding.dart';
import 'package:ekank/helpers/db_helper.dart';
import 'package:ekank/services/api/feed.service.dart';
import 'package:ekank/services/firebase/auth.service.dart';
import 'package:ekank/views/authenticate.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await initServices();
  await DBHelper().database;
  runApp(const MyApp());
}

Future initServices() async {
  await Get.putAsync<AuthService>(() async => AuthService());
  await Get.putAsync<FeedService>(() async => FeedService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      home: const AuthenticateView(),
    );
  }
}
