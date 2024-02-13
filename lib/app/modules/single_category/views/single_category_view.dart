import 'package:ecom_5/app/models/category.dart';
import 'package:ecom_5/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/single_category_controller.dart';

class SingleCategoryView extends GetView<SingleCategoryController> {
  const SingleCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.category ?? ''),
        centerTitle: true,
      ),
      body: controller.vehicles.isEmpty
          ? const Center(
              child: Text('No vehicles found for this category',
                  style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: controller.vehicles.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  height: 200,
                  child: SearchCard(vehicle: controller.vehicles[index]),
                );
              },
            ),
    );
  }
}
