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
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await Storage.removeAll();
            Get.offAllNamed(Routes.LOGIN);
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
