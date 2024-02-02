import 'dart:convert';

import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddVehicleController extends GetxController {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  XFile? image;
  var imageError = false.obs;

  String? selectedCategoryId;

  var formKey = GlobalKey<FormState>();

  void addVehicle() async {
    if (image == null) {
      imageError.value = true;
    }
    if (formKey.currentState!.validate() && image != null) {
      var url = Uri.http(ipAddress, 'ecom5_api/addVehicle.php');

      // var response = await http.post(url, body: {
      //   'email': emailController.text,
      //   'password': passwordController.text,
      //   'fullName': fullNameController.text,
      // });

      var request = http.MultipartRequest('POST', url);
      request.fields['token'] = Storage.getToken();
      request.fields['vehicle_name'] = titleController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['per_day_price'] = priceController.text;
      request.fields['category_id'] = selectedCategoryId!;
      request.files
          .add(await http.MultipartFile.fromPath('image', image!.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      var body = response.body;
      var result = jsonDecode(body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          title: 'Vehicle added successfully',
          message: result['message'],
        ));
        Get.close(1);
        Get.find<HomeController>().getVehicles();
      } else {
        Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          title: 'Vehicle add failed',
          message: result['message'],
        ));
      }
    }
  }

  void onPickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    imageError.value = false;
  }
}
