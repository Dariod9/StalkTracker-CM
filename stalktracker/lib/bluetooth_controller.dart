import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/signinpage.dart';
import 'package:hive/hive.dart';
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

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) async {
        print(r.device.address + " " + r.device.name.toString()+ " " +  r.rssi.toString());
        if(r.device.name!=null) nome=r.device.name!;
        else nome=r.device.address;


        var c;

        var box = await Hive.openBox('testBox');

        c = new Contact(name: nome,
              proximity: r.rssi,
              address: r.device.address,
              date: DateTime.now(),
              close: false,
              black: false,
              path1: "",
              path2: "",
              path3: "",
        );


        contactos.add(c);
      });

    return contactos;

  }

  static Future<List<Contact>> getClose() async {
    var box = await Hive.openBox('testBox');
    print(box.keys);
    // box.clear();
    List<Contact> lista=[];
    // print(box.length);
    // print(box.getAt(0).toString());
    // print(box.getAt(1).toString());
    // print(box.getAt(2).toString());

    try {
      var result = await box.values;
      for(Contact c in result) {
        // print(c.close);
        if (c.close) lista.add(c);
      }
    }
    catch(e){
      print("NÃO HA");
      print(e);
    }

    return lista;

  }

  static Future<List<Contact>> getBlack() async {
    var box = await Hive.openBox('testBox');
    List<Contact> lista=[];

    try {
      var result = await box.values;
      for(Contact c in result) {
        // print(c.close);
        if (c.black==true) lista.add(c);
      }
    }
    catch(e){
      print("NÃO HA");
      print(e);
    }

    return lista;

  }


  static Future<bool> existsInBox(String address) async {
    // print("A verificar o "+address);
    var box = await Hive.openBox('testBox');
    var keys= await box.keys;

    var r=false;
    // print("Para o "+address);
    for(var k in keys){
      // print(k);
      if(k==address){
        r=true;
        print("É igual ao "+k);
      }
    }

    return r;

    }


  static Future<bool> isClose(Contact c) async{
    var box = await Hive.openBox('testBox');
    var close=false;

    try {
      // print(box.get(0));
      // print("A ver o "+c.address);
      var result = await box.get(c.address);
      Contact got= result;
      print(got.close);
      print("WASSUP");
      if(got.close) close=true;
    }
    catch(e){
      print("NÃO EXISTE CONTACTO");
      print(e);
      return false;
    }
    return close;
  }

  static void clearClose() async {
    var box = await Hive.openBox('testBox');

    for (Contact c in box.values) {
      if(c.close==true) {
        Contact c2 = c;
        c2.black=false;
        await box.put(c.address,c2);
      }
    }
  }
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
