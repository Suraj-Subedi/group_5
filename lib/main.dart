import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const LoginPage(),
    ),
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      // color: Colors.orange,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
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
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
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
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
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
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('login ');
                  }
                },
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Counter App'),
      ),
      body: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                width: 300,
                child: const Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Text(
                counter.toString(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(counter);
          counter++;
          print(counter);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
