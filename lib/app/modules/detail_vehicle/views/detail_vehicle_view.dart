import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_vehicle_controller.dart';

class DetailVehicleView extends GetView<DetailVehicleController> {
  const DetailVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var vehicle = Get.arguments as Vehicle;
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name ?? ''),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: vehicle.vehicleId ?? '',
              child: Image(
                // width: double.infinity,
                image: NetworkImage(
                  getImageUrl(vehicle.imageUrl ?? ''),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  title: Text(vehicle.name ?? ''),
                  subtitle: Text(vehicle.description ?? ''),
                ),
                ListTile(
                  title: Text('Price'),
                  subtitle: Text('Rs. ${vehicle.perDayPrice ?? ''}'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.TEST_MAP);
                    },
                    child: Text('View Location')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: ElevatedButton(
          onPressed: controller.bookVehicle,
          child: const Text('Book Vehicle'),
        ),
      ),
    );
  }
}
