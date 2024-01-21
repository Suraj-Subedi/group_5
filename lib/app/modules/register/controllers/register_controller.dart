import 'dart:convert';

import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> onReigster() async {
    if (formKey.currentState!.validate()) {
      var url = Uri.http(ipAddress, 'ecom5_api/auth/register.php');
      var response = await http.post(url, body: {
        'email': emailController.text,
        'password': passwordController.text,
        'fullName': fullNameController.text,
      });

      var body = response.body;
      print(body);
      var result = jsonDecode(body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          title: 'Reistration complete',
          message: result['message'],
        ));
        Get.close(1);
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Reistration failed',
          message: result['message'],
        ));
      }
    }
  }
}
