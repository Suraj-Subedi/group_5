import 'dart:convert';

import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailVehicleController extends GetxController {
  void bookVehicle() async {
    try {
      DateTimeRange? dateRange = await showDateRangePicker(
          context: Get.context!,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)));

      if (dateRange == null) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Start and End Date is required',
          duration: Duration(seconds: 2),
        ));
        return;
      }

      var url = Uri.http(ipAddress, 'ecom5_api/makeBooking.php');
      var vehicle = Get.arguments as Vehicle;
      var response = await http.post(url, body: {
        'token': Storage.getToken(),
        'vehicle_id': vehicle.vehicleId ?? '',
        'start_date': dateRange.start.toIso8601String(),
        'end_date': dateRange.end.toIso8601String(),
      });

      var body = response.body;

      var result = jsonDecode(body);

      if (result['success'] ?? false) {
        // Get.close(1);
        Get.back();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 2),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'] ?? 'Failed to book vehicle',
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
