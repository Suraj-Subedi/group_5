import 'package:get/get.dart';

import '../controllers/test_map_controller.dart';

class TestMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestMapController>(
      () => TestMapController(),
    );
  }
}
