import 'package:admin_pannel/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Admin Panel!",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.greenAccent,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text(
                        "Are you sure you want to Logout?",
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signOut()
                                  .then((value) => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => LoginScreen(),
                                      ),
                                      (route) => false))
                                  .onError((error, stackTrace) =>
                                      print("error Signing Out"));
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),
      backgroundColor: Colors.green,
      body: Container(
        decoration: const BoxDecoration(),
        child: const Center(
            child: Text(
          "Welcome To DashBoard",
          style: TextStyle(fontSize: 28),
        )),
      ),
    );
  }
}
