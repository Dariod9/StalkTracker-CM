import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact {
  String _name="";

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int _proximity=0;

  int get proximity => _proximity;

  set proximity(int value) {
    _proximity = value;
  }

  // constructor
  Contact(String name, int proximity) {
    this.name = name;
    this.proximity = proximity;
  }
}