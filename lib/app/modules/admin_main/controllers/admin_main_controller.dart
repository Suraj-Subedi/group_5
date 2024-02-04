import 'package:ecom_5/app/modules/admin_category/views/admin_category_view.dart';
import 'package:ecom_5/app/modules/admin_home/views/admin_home_view.dart';
import 'package:ecom_5/app/modules/history/views/history_view.dart';
import 'package:ecom_5/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainController extends GetxController {
  List<Widget> pages = [
    AdminHomeView(),
    AdminCategoryView(),
    HistoryView(),
    ProfileView(),
  ];
  var currentIndex = 0.obs;
}
