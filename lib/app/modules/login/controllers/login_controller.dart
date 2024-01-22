import 'dart:convert';

import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLogin() async {
    if (formKey.currentState!.validate()) {
      var url = Uri.http(ipAddress, 'ecom5_api/auth/login.php');
      var response = await http.post(url, body: {
        'email': emailController.text,
        'password': passwordController.text,
      });

      var body = response.body;

      var result = jsonDecode(body);

      if (result['success']) {
        await Storage.setToken(result['token']);
        await Storage.setRole(result['role']);
        Get.showSnackbar(GetSnackBar(
          title: 'Logged in Successfully',
          message: result['message'],
        ));

        if (result['role'] == 'admin') {
          Get.offAllNamed(Routes.ADMIN_MAIN);
        } else {
          Get.offAllNamed(Routes.MAIN);
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Login failed',
          message: result['message'],
        ));
      }
    }
  }
}
