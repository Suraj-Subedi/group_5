import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx counter = 0.obs;

  void increment() => counter.value++;
}
