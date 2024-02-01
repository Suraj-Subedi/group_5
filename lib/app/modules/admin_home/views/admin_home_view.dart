import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AdminHomeView'),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return DataCard(
              index: index,
            );
          },
        ));
  }
}

class DataCard extends StatelessWidget {
  final int index;
  const DataCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.blue.shade300,
      Colors.green.shade300,
      Colors.teal.shade300,
      Colors.yellow.shade300,
    ];
    return Container(
        decoration: BoxDecoration(
            color: colors[index],
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Users',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(
              '10K',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ));
  }
}
