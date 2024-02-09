import 'package:ecom_5/app/models/stats.dart';
import 'package:ecom_5/app/models/vehicles.dart';

import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminHomeController extends GetxController {
  StatsResponse? statsResponse;

  @override
  void onInit() {
    super.onInit();
    getStats();
  }

  Future<void> getStats() async {
    try {
      var url = Uri.http(ipAddress, 'ecom5_api/getStats.php');

      var response = await http.post(url, body: {'token': Storage.getToken()});

      var body = response.body;

      var result = statsResponseFromJson(body);

      if (result.success ?? false) {
        statsResponse = result;
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
