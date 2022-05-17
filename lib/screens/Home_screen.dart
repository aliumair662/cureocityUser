import 'package:cureocityuser/comstants/colors.dart';
import 'package:cureocityuser/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double _weight = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lahore',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.location_on,
          color: primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Sam Smith',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Find your medicines',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: InputBorder.none,
                    label: Text(
                      'Search Medicines',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop by Category',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                height: 15 * _height / 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            color: Colors.amber,
                            width: _weight * 33 / 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'OTC Medicines',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Offers',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                height: 13 * _height / 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            color: Colors.cyanAccent,
                            width: _weight * 60 / 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Stay Home Get Discount',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sellers near you',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                height: 10 * _height / 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: _weight * 50 / 100,
                            color: Colors.grey[200],
                            child: ListTile(
                              leading: Icon(Icons.image),
                              title: Text(
                                'Well Life Store',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              subtitle: Text('Willington Bridge'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
