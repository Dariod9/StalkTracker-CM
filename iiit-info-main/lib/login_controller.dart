import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon/googleloginmain.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/signinpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  authentication() async {
    if (_googleSignIn.isSignedIn() == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('gmail');
      return loginpage();
    } else {
      googleAccount.value = await _googleSignIn.signIn();
      return signinpage();
    }
  }

  login(BuildContext context) async {
    googleAccount.value = await _googleSignIn.signIn();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gmail', _googleSignIn.currentUser?.email ?? '');
    print(prefs.getString('gmail'));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => afterlogingmail(),
        ));
  }

  logout(BuildContext context) async {
    googleAccount.value = await _googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('gmail');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginpage(),
        ));
  }
}
