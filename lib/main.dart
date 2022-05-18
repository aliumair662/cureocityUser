import 'package:cureocityuser/comstants/constants.dart';
import 'package:cureocityuser/screens/ButtonBar_screen.dart';
import 'package:cureocityuser/screens/login_screen.dart';
import 'package:cureocityuser/screens/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: appBarColor,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return BottomBarScreen();
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}
