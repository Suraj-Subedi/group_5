import 'package:ecom_5/app/modules/bookings/views/bookings_view.dart';
import 'package:ecom_5/app/modules/home/views/home_view.dart';
import 'package:ecom_5/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> pages = [
    HomeView(),
    BookingsView(),
    ProfileView(),
  ];
  var currentIndex = 0.obs;
}
