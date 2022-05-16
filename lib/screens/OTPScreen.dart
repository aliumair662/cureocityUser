import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cureocityuser/screens/Home_screen.dart';
import 'package:cureocityuser/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../comstants/constants.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({required this.phone, Key? key}) : super(key: key);
  final String phone;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String verificationCode = '';
  Timer? _countdownTimer;
  bool isButtonEnabled = true;

  Duration myDuration = Duration(seconds: 60);
  void startTimer() {
    _countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => _countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    setState(() => myDuration = Duration(seconds: 60));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        _countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    _verifyPhone();
    startTimer();
    super.initState();
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          String userId = _auth.currentUser!.uid;
          if (value != null) {
            DocumentSnapshot data =
                await firestore.collection('users').doc(userId).get();
            if (data.exists) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddUserdataScreen()));
            }
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      },
      codeSent: (String verificationId, [foreResendingToken]) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String strDigits(int n) => n.toString().padLeft(1, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
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
            padding: EdgeInsets.only(top: height * 10.0 / 100),
            child: Center(
              child: Text(
                'We have sent an OTP verificatin code\n on your given number.',
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              maxLength: 6,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.grey[100],
                filled: true,
                border: InputBorder.none,
                label: Text(
                  'Enter 4 digit OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: height * 6 / 100,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    return primaryColor;
                  })),
                  onPressed: () {
                    onCompleted:
                    (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode,
                          smsCode: pin,
                        ));
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    };
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0:$seconds min left',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print(widget.phone);
                    }
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(widget.phone)));
                    resetTimer();
                  },
                  child: Text(
                    'RESEND',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
