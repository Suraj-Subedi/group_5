import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../controllers/detail_vehicle_controller.dart';

class DetailVehicleView extends GetView<DetailVehicleController> {
  // final Vehicle vehicle = Get.arguments;
  const DetailVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var vehicle = Get.arguments as Vehicle;
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name ?? ''),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: vehicle.vehicleId ?? '',
              child: Image(
                // width: double.infinity,
                image: NetworkImage(
                  getImageUrl(vehicle.imageUrl ?? ''),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(vehicle.name ?? ''),
                  subtitle: Text(vehicle.description ?? ''),
                ),
                ListTile(
                  title: const Text('Price'),
                  subtitle: Text('Rs. ${vehicle.perDayPrice ?? ''}'),
                ),
                Obx(
                  () => Row(
                    children: [
                      controller.vehicleRating.value == 0.0
                          ? const Text('No ratings yet!')
                          : RatingBar.builder(
                              initialRating: controller.vehicleRating.value,
                              minRating: 1,
                              ignoreGestures: true,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RatingDialog(
                            vehicleId: vehicle.vehicleId ?? '',
                          );
                        },
                      );
                    },
                    child: const Text('Give your rating'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.toNamed(Routes.TEST_MAP);
                //     },
                //     child: Text('View Location')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: ElevatedButton(
          onPressed: controller.bookVehicle,
          child: const Text('Book Vehicle'),
        ),
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final String vehicleId;
  const RatingDialog({super.key, required this.vehicleId});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  var myRating = 3.0;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DetailVehicleController>();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Give Rating',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  myRating = rating;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.giveRating(myRating, widget.vehicleId);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
