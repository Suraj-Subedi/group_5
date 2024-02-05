import 'package:ecom_5/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminCategoryController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AddCategoryPopup();

                // return AlertDialog(
                //   title: const Text('Add Category'),
                //   content: TextField(
                //     controller: controller.categoryController,
                //     decoration: const InputDecoration(
                //       labelText: 'Category name',
                //       hintText: 'Enter Category Name',
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                //   actions: [
                //     TextButton(
                //       onPressed: () {
                //         controller.addCategory();
                //         Get.back();
                //       },
                //       child: const Text('Add'),
                //     ),
                //   ],
                // );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Categories'),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.categoryResponse == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: controller.categoryResponse!.categories?.length ?? 0,
              itemBuilder: (context, index) {
                var category = controller.categoryResponse!.categories![index];
                return ListTile(
                  title: Text(category.category ?? ''),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          var isDeleted = category.isDeleted == '1';
                          return AlertDialog(
                            title: Text(
                                '${isDeleted ? 'Restore' : "Delete"} Category'),
                            content: Text(
                                'Are you sure you want to ${isDeleted ? 'Restore' : "Delete"} ${category.category}?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  controller.updateCategoryStatus(
                                    category.categoryId!,
                                  );
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      category.isDeleted == '1' ? Icons.restore : Icons.delete,
                      color:
                          category.isDeleted == '1' ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

class AddCategoryPopup extends StatelessWidget {
  const AddCategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminCategoryController>();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Category', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              TextField(
                controller: controller.categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category name',
                  hintText: 'Enter Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: controller.addCategory,
                child: const Text(
                  'Add Category',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
