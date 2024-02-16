import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/theme.dart';
import 'package:ecom_5/translations.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();

  runApp(
    KhaltiScope(
        publicKey: 'test_public_key_dde0878862604f24b2475a9806c833d2',
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            translations: MyTranslations(),
            locale: const Locale('en'),
            fallbackLocale: const Locale('np'),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            defaultTransition: Transition.cupertino,
            theme: lightTheme,

            // darkTheme: darkTheme,
            title: "Application",
            initialRoute: Routes.SPLASH,
            getPages: AppPages.routes,
          );
        }),
  );
}
