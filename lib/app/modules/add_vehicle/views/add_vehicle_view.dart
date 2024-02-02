import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_vehicle_controller.dart';

class AddVehicleView extends GetView<AddVehicleController> {
  const AddVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Add your vehicle on',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Pahuna Wheels',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null) {
                      return null;
                    }
                    if (v.isEmpty) {
                      return 'Please enter your vehicle title';
                    }
                    return null;
                  },
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your vehicle title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null) {
                      return null;
                    }
                    if (v.isEmpty) {
                      return 'Please enter your vehicle description';
                    } else if (v.length < 10) {
                      return 'Description must be at least 10 characters';
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: 5,
                  maxLength: 2000,
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your vehicle description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (v) {
                    if (v == null) {
                      return null;
                    }
                    if (v.isEmpty) {
                      return 'Please enter your per day price';
                    } else if (int.tryParse(v) == null) {
                      return 'Please enter valid price';
                    }
                    return null;
                  },
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your per day price',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: controller.selectedCategoryId,
                  items: Get.find<HomeController>()
                      .categoryResponse!
                      .categories!
                      .map((e) => DropdownMenuItem(
                            value: e.categoryId,
                            child: Text(e.category!),
                          ))
                      .toList(),
                  onChanged: (v) {
                    controller.selectedCategoryId = v;
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please select your vehicle type';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Select your vehicle type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: controller.onPickImage,
                  child: const Text(
                    'Select Image',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.imageError.value,
                    child: const Text(
                      'Image is required',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: controller.addVehicle,
                  child: const Text(
                    'Add Vehicle',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
