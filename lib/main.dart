import 'package:ecom_5/app/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  var token = Storage.getToken();
  var role = Storage.getRole();

  runApp(
    KhaltiScope(
        publicKey: 'test_public_key_dde0878862604f24b2475a9806c833d2',
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            defaultTransition: Transition.cupertino,
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
          );
        }),
  );
}
