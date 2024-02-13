import 'package:ecom_5/app/models/category.dart';
import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class SingleCategoryController extends GetxController {
  List<Vehicle> vehicles = [];

  @override
  void onInit() {
    super.onInit();
    var controller = Get.find<HomeController>();
    var totalVehicles = controller.vehiclesResponse?.vehicles ?? [];
    var category = Get.arguments as Category;
    for (var vehicle in totalVehicles) {
      if (vehicle.categoryId == category.categoryId) {
        vehicles.add(vehicle);
      }
    }
  }
}
