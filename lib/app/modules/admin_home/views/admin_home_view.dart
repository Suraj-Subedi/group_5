import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
        ),
        body: GetBuilder<AdminHomeController>(
          builder: (controller) {
            if (controller.statsResponse == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.statsResponse?.stats?.length ?? 0,
              itemBuilder: (context, index) {
                return DataCard(
                  index: index,
                  label: controller.statsResponse?.stats?[index].label ?? "",
                  value: controller.statsResponse?.stats?[index].value ?? "",
                );
              },
            );
          },
        ));
  }
}

class DataCard extends StatelessWidget {
  final String label;
  final String value;
  final int index;
  const DataCard(
      {super.key,
      required this.index,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.blue.shade300,
      Colors.green.shade300,
      Colors.teal.shade300,
      Colors.yellow.shade300,
      Colors.red.shade300,
    ];
    return Container(
        decoration: BoxDecoration(
            color: colors[index % colors.length],
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ));
  }
}
