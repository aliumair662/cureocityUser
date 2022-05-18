import 'package:cureocityuser/comstants/colors.dart';
import 'package:cureocityuser/comstants/constants.dart';
import 'package:cureocityuser/screens/medicine_detail_screen.dart';
import 'package:cureocityuser/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MedicineCotegoryListScreen extends StatefulWidget {
  const MedicineCotegoryListScreen({Key? key}) : super(key: key);

  @override
  State<MedicineCotegoryListScreen> createState() =>
      _MedicineCotegoryListScreenState();
}

class _MedicineCotegoryListScreenState
    extends State<MedicineCotegoryListScreen> {
  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Care',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ))
        ],
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: appBarColor,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MedicineDetailScreen()));
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/medicine.png',
                        fit: BoxFit.fitHeight,
                        width: _heigth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Salospir 100mg',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Tablet',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '\$ 3.5',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 55,
                          child: TextButton.icon(
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.resolveWith((states) {
                                  return EdgeInsets.zero;
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return primaryColor;
                                }),
                              ),
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: Text('')),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
