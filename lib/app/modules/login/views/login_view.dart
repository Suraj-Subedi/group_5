import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = 50;
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
                height: 150,
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
                'Welcome to',
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
                onPressed: controller.onLogin,
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}



// class MyCounter extends StatelessWidget {
//   final int counter;
//   const MyCounter({super.key, required this.counter});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.red,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.red,
//               ),
//               width: 300,
//               child: const Text(
//                 'You have pushed the button this many times:',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Center(
//             child: Text(
//               counter.toString(),
//               style: TextStyle(
//                 fontSize: 50,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
