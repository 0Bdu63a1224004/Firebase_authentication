import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/SignInScreen.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MainPAge(),
    );
  }
}

class MainPAge extends StatefulWidget {
  const MainPAge({super.key});

  @override
  State<MainPAge> createState() => _MainPAgeState();
}

class _MainPAgeState extends State<MainPAge> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> signin(String emai, String pass) async {
    try {
      UserCredential userC = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emai, password: pass);
      if (userC.user != null) {
        Get.to(SignInScreen());
      } else {
        print("errorr");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Sign Up"),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "abc@gmail.com",
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                    hintText: "123456",
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signin(_emailController.text.trim(),
                          _passController.text.trim());
                    }
                  },
                  child: Text("Sign up")),
             
            ],
          ),
        ),
      ),
    );
  }
}
