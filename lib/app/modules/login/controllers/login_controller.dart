import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLogin() {
    if (formKey.currentState!.validate()) {
      Get.offNamed(Routes.MAIN);
    }
  }
}
