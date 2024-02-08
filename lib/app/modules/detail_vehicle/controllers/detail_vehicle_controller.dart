import 'dart:convert';

import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';

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
        var amount = (dateRange.end.difference(dateRange.start).inDays + 1) *
            (double.tryParse(vehicle.perDayPrice ?? '0') ?? 0);
        startPayment(
            (amount * 100).toInt(), vehicle.name ?? '', result['booking_id']);
        // Get.close(1);
        // Get.back();
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 2),
        // ));
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

  void startPayment(int amount, String vehicleName, int bookingId) async {
    try {
      var config = PaymentConfig(
          amount: amount,
          productIdentity: bookingId.toString(),
          productName: vehicleName);
      KhaltiScope.of(Get.context!).pay(
          preferences: [
            PaymentPreference.khalti,
          ],
          config: config,
          onSuccess: (v) async {
            var url = Uri.http(ipAddress, 'ecom5_api/makePayment.php');

            var response = await http.post(url, body: {
              'token': Storage.getToken(),
              'booking_id': bookingId.toString(),
              'amount': amount.toString(),
            });

            var body = response.body;

            var result = jsonDecode(body);

            if (result['success'] ?? false) {
              Get.close(1);
              Get.back();
              Get.showSnackbar(const GetSnackBar(
                backgroundColor: Colors.green,
                message: 'Vehicle booked successfully',
                duration: Duration(seconds: 2),
              ));
            } else {
              Get.showSnackbar(GetSnackBar(
                backgroundColor: Colors.red,
                message: result['message'] ?? 'Failed to book vehicle',
                duration: const Duration(seconds: 2),
              ));
            }
          },
          onFailure: (v) {
            Get.showSnackbar(const GetSnackBar(
              backgroundColor: Colors.red,
              message: 'Failed to book vehicle',
              duration: Duration(seconds: 2),
            ));
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
