import 'package:flutter/material.dart';

//screens
import 'package:cureocityuser/screens/screens.dart';

//constants
import '../comstants/constants.dart';

//services

//external packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controllers
  TextEditingController _controller = TextEditingController();
  final _form = GlobalKey<FormState>();

  //Instanses and variables
  bool _isLoading = false;
  bool _googleLoading = false;
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final firestore = FirebaseFirestore.instance;
  String coutryCode = '';

  //Functions for different Sign-In Methonds
  //Sign-In with Google//
  Future _googleLogin() async {
    try {
      setState(() {
        _googleLoading = true;
      });
      final user = await googleSignIn.signIn();
      if (user == null) {
        setState(() {
          _googleLoading = false;
          return;
        });
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        if (_auth.currentUser!.uid != null) {
          firestore.collection('users').doc(_auth.currentUser!.uid).set({
            'userId': _auth.currentUser!.uid.toString(),
            'date': DateTime.now(),
          });
        }
        setState(() {
          _isLoading = _googleLoading;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Sign-In with Facebook
  Future _FacebookLogin() async {
    try {
      setState(() {
        _googleLoading = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Country Code Picker
  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 6.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: hieght,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Colors.lightBlue[200],
                width: double.infinity,
                height: 60 * hieght / 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: hieght * 10 / 100),
                      child: SizedBox(
                        height: hieght * 10 / 100,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hieght * 25 / 100,
                      child: Container(
                        child: Image.asset(
                          'assets/images/doctor_emoji.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: hieght * 54 / 100,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: hieght * 9 / 100,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.mobile_friendly,
                                    color: primaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: CountryPickerDropdown(
                                    initialValue: 'pk',
                                    itemBuilder: _buildDropdownItem,
                                    onValuePicked: (Country country) {
                                      // print("${country.phoneCode}");
                                      coutryCode = country.phoneCode;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone Number",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Form(
                            //   child: TextFormField(
                            //     controller: _controller,
                            //     maxLength: 10,
                            //     keyboardType: TextInputType.phone,
                            //     textAlignVertical: TextAlignVertical.top,
                            //     decoration: const InputDecoration(
                            //       label: Text(
                            //         'Enter Mobile Number',
                            //         style:
                            //             TextStyle(fontWeight: FontWeight.w600),
                            //       ),
                            //       disabledBorder: InputBorder.none,
                            //       floatingLabelBehavior:
                            //           FloatingLabelBehavior.never,
                            //       prefixIcon: Icon(
                            //         Icons.mobile_friendly,
                            //         color: primaryColor,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: hieght * 7 / 100,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return primaryColor;
                                })),
                                onPressed: () {
                                  if (coutryCode.isEmpty) {
                                    String number =
                                        '+' + '92' + _controller.text.trim();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => OTPScreen(
                                                phone: number,
                                              )),
                                    );
                                  } else {
                                    String number = '+' +
                                        coutryCode +
                                        _controller.text.trim();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => OTPScreen(
                                                  phone: number,
                                                )));
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: hieght * 80 / 100,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Or quick continue with',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 10 * hieght / 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return Color.fromRGBO(59, 89, 152, 100);
                                    }),
                                  ),
                                  onPressed: () async {
                                    final result = await FacebookAuth.instance
                                        .login(permissions: [
                                      'public_profile',
                                      'email'
                                    ]);
                                    if (result.status == LoginStatus.success) {
                                      final requestData = await FacebookAuth.i
                                          .getUserData(fields: 'email,name');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen()));
                                    }
                                  },
                                  icon: Icon(Icons.facebook),
                                  label: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      'Facebook',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    return Colors.white;
                                  })),
                                  onPressed: _googleLogin,
                                  icon: FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Colors.blue,
                                  ),
                                  label: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
