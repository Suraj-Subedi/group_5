import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyVehiclesController extends GetxController {
  VehiclesResponse? vehiclesResponse;

  @override
  void onInit() {
    super.onInit();
    getMyVehicles();
  }

  Future<void> getMyVehicles() async {
    try {
      var url = Uri.http(ipAddress, 'ecom5_api/getMyVehicles.php');

      var response = await http.post(url, body: {'token': Storage.getToken()});

      var body = response.body;

      var result = vehiclesResponseFromJson(body);

      if (result.success ?? false) {
        vehiclesResponse = result;
        update();
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
