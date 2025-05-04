import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> signIn(String emai, String pass) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emai, password: pass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.to(Home());
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
                child: Text("Sign in"),
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
                      signIn(_emailController.text.trim(),
                          _passController.text.trim());
                    }
                  },
                  child: Text("Sign in")),
            ],
          ),
        ),
      ),
    );
  }
}
