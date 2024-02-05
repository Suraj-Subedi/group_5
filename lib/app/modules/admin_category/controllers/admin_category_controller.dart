import 'dart:convert';

import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminCategoryController extends GetxController {
  var categoryController = TextEditingController();
  var key = GlobalKey<FormState>();

  void addCategory() async {
    if (key.currentState!.validate()) {
      var url = Uri.http(ipAddress, 'ecom5_api/addCategory.php');
      var response = await http.post(url, body: {
        'token': Storage.getToken(),
        'category_name': categoryController.text,
      });

      var body = response.body;

      var result = jsonDecode(body);

      if (result['success']) {
        Get.close(1);
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          title: 'Category added successfully',
          message: result['message'],
        ));
        categoryController.clear();

        Get.find<HomeController>().getCategories();
      } else {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          title: 'Failed to add category',
          message: result['message'],
        ));
      }
    }
  }
}
