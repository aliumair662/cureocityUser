import 'package:cureocityuser/comstants/colors.dart';
import 'package:cureocityuser/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
              return primaryColor;
            })),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Log-Out')),
      )),
    );
  }
}
