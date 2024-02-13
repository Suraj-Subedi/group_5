import 'package:ecom_5/app/models/vehicles.dart';
import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:ecom_5/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pahuna Wheels'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchView());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_VEHICLE);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getCategories();
          await controller.getVehicles();
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Get.height,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: GetBuilder<HomeController>(
              // init: HomeController(),
              builder: (controller) {
                if (controller.vehiclesResponse == null ||
                    controller.categoryResponse == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Text(
                        'Top Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            controller.categoryResponse?.categories?.length ??
                                0,
                        itemBuilder: (context, index) {
                          var category =
                              controller.categoryResponse!.categories?[index];

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.SINGLE_CATEGORY,
                                arguments: category,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  category?.category ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Text(
                        'Recommended for you',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                        // physics: const BouncingScrollPhysics(
                        //   parent: AlwaysScrollableScrollPhysics(),
                        // ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            controller.vehiclesResponse?.vehicles?.length ?? 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          var vehicle =
                              controller.vehiclesResponse?.vehicles?[index];
                          return VehicleCard(vehicle: vehicle ?? Vehicle());
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_VEHICLE, arguments: vehicle);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.name ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 7,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        vehicle.category ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "Rs.${vehicle.perDayPrice ?? ''}/day",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var controller = Get.find<HomeController>();
    var vehicles = controller.vehiclesResponse?.vehicles ?? [];
    var suggestions = [];
    suggestions = query.trim().isEmpty
        ? []
        : vehicles.where((element) {
            return (element.name ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()) ||
                (element.category ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()) ||
                (element.perDayPrice ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase().trim());
          }).toList();

    if (suggestions.isEmpty && query.trim().isNotEmpty) {
      return const Center(
        child: Text('No results found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      );
    }

    if (suggestions.isEmpty && query.trim().isEmpty) {
      return const Center(
        child: Text('Search for vehicles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          height: 200,
          child: SearchCard(vehicle: suggestions[index]),
        );
      },
    );
  }
}

class SearchCard extends StatelessWidget {
  final Vehicle vehicle;
  const SearchCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_VEHICLE, arguments: vehicle);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Image(
                // width: double.infinity,
                image: NetworkImage(
                  getImageUrl(vehicle.imageUrl ?? ''),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.name ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 7,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        vehicle.category ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "Rs.${vehicle.perDayPrice ?? ''}/day",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
