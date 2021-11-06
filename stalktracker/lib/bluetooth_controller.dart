import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/contact.dart';

class BluetoothController {

  static final FlutterBlue blue = FlutterBlue.instance;

  static getDevices(){
    blue.startScan(timeout: Duration(seconds: 30));
    List<Contact> contactos= <Contact>[];
    var subscription = blue.scanResults.listen((results) {
      // do something with scan results
      if(results.isNotEmpty) {
        for (ScanResult r in results) {
          // print('${r.device.name} found! rssi: ${r.rssi}');
          contactos.add(new Contact(r.device.name, r.rssi));
        }
      }
    });
    blue.stopScan();

    return contactos;

  }

  // authentication() async {
  //   if (_googleSignIn.isSignedIn() == true) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.remove('gmail');
  //     return loginpage();
  //   } else {
  //     googleAccount.value = await _googleSignIn.signIn();
  //     return signinpage();
  //   }
  // }
  //
  // login(BuildContext context) async {
  //   print("AQUU ->");
  //
  //   googleAccount.value = await _googleSignIn.signIn();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('gmail', _googleSignIn.currentUser?.email ?? '');
  //   print(prefs.getString('gmail'));
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => afterlogingmail(),
  //       ));
  // }
  //
  // logout(BuildContext context) async {
  //   googleAccount.value = await _googleSignIn.signOut();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('gmail');
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => loginpage(),
  //       ));
  // }
}