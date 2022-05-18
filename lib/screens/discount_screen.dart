import 'package:cureocityuser/comstants/constants.dart';
import 'package:flutter/material.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Offers',
          style: appBarTextStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Get 50% off on first Medicine order',
                  ),
                ),
                trailing: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return Colors.grey[100];
                      },
                    ),
                    elevation: MaterialStateProperty.resolveWith(
                      (states) {
                        return 0;
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Get 50%',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
