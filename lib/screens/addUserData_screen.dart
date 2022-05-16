import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cureocityuser/screens/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../comstants/constants.dart';

class AddUserdataScreen extends StatefulWidget {
  const AddUserdataScreen({Key? key}) : super(key: key);

  @override
  State<AddUserdataScreen> createState() => _AddUserdataScreenState();
}

class _AddUserdataScreenState extends State<AddUserdataScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailControlle = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Now'),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: accentColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: accentColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 7.0 / 100),
            child: Center(
              child: Text(
                'Your phone number is not registered yet.\nLet us know basic details for registration.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 5 / 100,
          ),
          Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        return value!.isEmpty ? 'Please enter name' : null;
                      },
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: InputBorder.none,
                          label: Text(
                            'Full Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: primaryColor,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: TextFormField(
                      validator: (value) {
                        return !value!.contains('@')
                            ? 'Please enter a valid email address'
                            : null;
                      },
                      controller: _emailControlle,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: InputBorder.none,
                          label: Text(
                            'Email Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: primaryColor,
                          )),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: height * 6 / 100,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    return primaryColor;
                  })),
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      String userId = _auth.currentUser!.uid;
                      firestore.collection('users').doc(userId).set({
                        'userId': userId,
                        'name': _nameController.text.trim(),
                        'email': _emailControlle.text.trim(),
                      }).then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      });
                    }
                  },
                  child: const Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
