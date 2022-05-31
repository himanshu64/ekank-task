import 'package:ekank/services/api/feed.service.dart';
import 'package:ekank/services/firebase/auth.service.dart';
import 'package:ekank/viewmodels/auth.viewmodel.dart';
import 'package:ekank/viewmodels/feed.viewmodel.dart';
import 'package:ekank/viewmodels/login.viewmodel.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthViewModel>(() => AuthViewModel(), fenix: true);
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(), fenix: true);

    Get.lazyPut<FeedViewModel>(
      () => FeedViewModel(),
    );
  }
}
