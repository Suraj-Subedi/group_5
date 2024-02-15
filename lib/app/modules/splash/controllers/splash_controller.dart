import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 2));
    var token = Storage.getToken();
    var role = Storage.getRole();
    if (token != null) {
      if (role != "admin") {
        Get.offNamed(Routes.MAIN);
      } else {
        Get.offNamed(Routes.ADMIN_MAIN);
      }
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
