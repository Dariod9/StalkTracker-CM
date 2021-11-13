import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/contact.dart';

class BluetoothController {

  static final FlutterBlue blue = FlutterBlue.instance;
  // static final FlutterBluetoothSerial blue2;

  static getDevices(){
    List<Contact> contactos = <Contact>[];

    // try {
    //   blue.startScan(timeout: Duration(seconds: 3));
    //   var subscription = blue.scanResults.listen((results) {
    //     // do something with scan results
    //     if (results.isNotEmpty) {
    //       for (ScanResult r in results) {
    //         print('${r.device.name} found! rssi: ${r.rssi}');
    //         contactos.add(new Contact(r.device.name, r.rssi));
    //       }
    //     }
    //   });
    //   blue.stopScan();
    // }
    // catch(e) {
    //   contactos=<Contact>[];
    // }

    return contactos;

  }

  static getDevices2(){
    List<Contact> contactos = <Contact>[];

    String nome="";

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
        print(r.device.address + " " + r.device.name.toString()+ " " +  r.rssi.toString());
        if(r.device.name!=null) nome=r.device.name!;
        else nome=r.device.address;
        contactos.add(new Contact(name: nome,proximity: r.rssi,address: r.device.address, date: DateTime.now()));
      });
    List<String> enderecos=<String>[];
    var finalCont=<Contact>[];

    contactos.forEach((f) {if(!enderecos.contains(f.address)){ enderecos.add(f.address); finalCont.add(f);}});


    // app.onDiscovery(r);
    return contactos;

  }

  // static discovery() {
  //
  // return contactos;

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
