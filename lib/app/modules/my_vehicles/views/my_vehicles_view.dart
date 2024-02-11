import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_vehicles_controller.dart';

class MyVehiclesView extends GetView<MyVehiclesController> {
  const MyVehiclesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Vehicles'),
          centerTitle: true,
        ),
        body: GetBuilder<MyVehiclesController>(
          builder: (controller) {
            if (controller.vehiclesResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: controller.vehiclesResponse?.vehicles?.length ?? 0,
              itemBuilder: (context, index) {
                var vehicle = controller.vehiclesResponse?.vehicles?[index];
                return ListTile(
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        getImageUrl(
                          vehicle?.imageUrl ?? '',
                        ),
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        vehicle?.name ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          var isDeleted = vehicle?.isDeleted == '1';
                          return AlertDialog(
                            title: Text(
                                '${isDeleted ? 'Restore' : "Delete"} Vehicle'),
                            content: Text(
                                'Are you sure you want to ${isDeleted ? 'Restore' : "Delete"} ${vehicle?.name ?? ""}?'),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                      // controller.deleteVehicle(vehicle?.vehicleId ?? '');
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
