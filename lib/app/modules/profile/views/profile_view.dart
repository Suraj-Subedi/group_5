import 'package:ecom_5/app/routes/app_pages.dart';
import 'package:ecom_5/app/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            if (controller.profileResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://ui-avatars.com/api/?name=${controller.profileResponse?.user?.fullName ?? 'User'}&background=0D8ABC&color=fff',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.profileResponse?.user?.fullName ?? 'User',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.profileResponse?.user?.email ?? 'Email',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    controller.profileResponse?.user?.role?.toUpperCase() ??
                        'Role',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: Storage.getRole() != 'admin',
                    child: ListTile(
                      title: const Text('My Vehicles'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.toNamed(Routes.MY_VEHICLES);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Logout'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure you want to Logout'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Storage.removeAll();
                                  Get.offAllNamed(Routes.LOGIN);
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
                  ),
                ],
              ),
            );
          },
        ));
  }
}
