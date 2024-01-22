import 'package:ecom_5/app/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  var token = Storage.getToken();
  var role = Storage.getRole();

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      title: "Application",
      initialRoute: token == null
          ? Routes.LOGIN
          : role == 'admin'
              ? Routes.ADMIN_MAIN
              : Routes.MAIN,
      getPages: AppPages.routes,
    ),
  );
}
