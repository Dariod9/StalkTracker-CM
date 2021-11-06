import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/afterloginmainpage.dart';

class changepassword extends StatefulWidget {
  @override
  State<changepassword> createState() => _loginpageState();
}

class _loginpageState extends State<changepassword> {
  bool _isObscure = true;
  final currentpasswordcontroller = TextEditingController();
  final newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Change Password',
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
                    'Change Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
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
                                email:
                                    FirebaseAuth.instance.currentUser?.email ??
                                        '')
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        afterloginmainpage())));
                      },
                      child: Text(
                        'Send password update link to email',
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
