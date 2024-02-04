import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_main_controller.dart';

class AdminMainView extends GetView<AdminMainController> {
  const AdminMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(
              color: Colors.blue,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
            ),
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ]),
      ),
    );
  }
}
