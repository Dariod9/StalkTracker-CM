import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/signinpage.dart';

class forgotpassword extends StatefulWidget {
  @override
  State<forgotpassword> createState() => _loginpageState();
}

class _loginpageState extends State<forgotpassword> {
  final usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Forgot Password',
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
                    'Forgot Password',
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
                            .sendPasswordResetEmail(
                                email: usernamecontroller.text)
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => signinpage(),
                                )));
                      },
                      child: Text(
                        'Reset Password',
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
