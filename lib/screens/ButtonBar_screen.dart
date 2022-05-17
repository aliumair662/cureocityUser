import 'package:flutter/material.dart';
import 'package:cureocityuser/comstants/colors.dart';
import 'package:cureocityuser/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  var _currentIndex = 0;
  final screens = [
    HomeScreen(),
    DoctorScreen(),
    HospitalScreen(),
    AppointmentScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text("Shop"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userDoctor,
            ),
            title: Text("doctors"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.location_pin),
            title: Text("hospitals"),
            selectedColor: Colors.orange,
          ),
          //Appointments
          SalomonBottomBarItem(
            icon: Icon(Icons.checklist_outlined),
            title: Text("Appointments"),
            selectedColor: Colors.teal,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
