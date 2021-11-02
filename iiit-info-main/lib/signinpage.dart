import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/afterloginmainpage.dart';
import 'package:hackathon/forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signinpage extends StatefulWidget {
  @override
  State<signinpage> createState() => _loginpageState();
}

class _loginpageState extends State<signinpage> {
  bool _isObscure = true;
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'SignIn',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'SignIn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: usernamecontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Email ID',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: _isObscure,
                  style: TextStyle(color: Colors.white),
                  controller: passwordcontroller,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => forgotpassword(),
                        ));
                  },
                  child: Text('Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: 15))),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: usernamecontroller.text,
                                password: passwordcontroller.text)
                            .then((value) async {
                          if (FirebaseAuth
                                  .instance.currentUser?.emailVerified ==
                              true) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('Email', usernamecontroller.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => afterloginmainpage(),
                                ));
                          } else {
                            return Fluttertoast.showToast(
                                msg: 'User not verified',
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 18,
                                backgroundColor: Colors.white,
                                textColor: Colors.black);
                          }
                        });
                      },
                      child: Text(
                        'Signin',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
