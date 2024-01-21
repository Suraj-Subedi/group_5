import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      // color: Colors.orange,
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/logo.jpg',
                height: 200,
              ),
              // Image.network(
              //   "https://hips.hearstapps.com/hmg-prod/images/2019-hyundai-kona-1548195339.jpg",
              //   height: 200,
              // ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Register your acccount on',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Pahuna Wheels',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return null;
                  }
                  if (v.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                controller: controller.fullNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return null;
                  }
                  if (v.isEmpty) {
                    return 'Please enter your email';
                  } else if (!GetUtils.isEmail(v)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (v) {
                  if (v == null) {
                    return null;
                  }
                  if (v.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: controller.onReigster,
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
