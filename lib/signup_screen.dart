import 'package:admin_pannel/dashboard_screen.dart';
import 'package:admin_pannel/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
                child: const Icon(
                  Icons.person,
                  size: 150,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  controller: passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: (ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (emailController.text.trim() != '' &&
                          passwordController.text != '') {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                            .then(
                              (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const DashboardScreen()),
                                (route) => false,
                              ),
                            )
                            .onError(
                          (error, stackTrace) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Center(
                                      child: Text("Login Unsuccessfull!!")),
                                  content: const Text("Invalid Credentials!"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Have any Account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    child: const Text(
                      "Login Now!",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
