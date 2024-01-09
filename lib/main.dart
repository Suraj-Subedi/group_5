import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      title: "Application",
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
