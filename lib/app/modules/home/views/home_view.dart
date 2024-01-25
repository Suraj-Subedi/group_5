import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pahuna Wheels'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          if (controller.vehiclesResponse == null) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
              itemCount: controller.vehiclesResponse?.vehicles?.length ?? 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var vehicle = controller.vehiclesResponse?.vehicles?[index];
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        vehicle?.name ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
