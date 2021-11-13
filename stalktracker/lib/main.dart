import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hackathon/afterloginmainpage.dart';
import 'package:hackathon/drawers/maindrawer.dart';
import 'package:hackathon/login_controller.dart';
import 'package:hackathon/signinpage.dart';
import 'package:hackathon/signup/signup.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/contact.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('Email');
  runApp(email == null
      //? (gmail == null
      ? MyApp() // : afterlogingmailapp())
      : afterloginapp());
  launchContactDB();

}

Future<void> launchContactDB() async {
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
// The created directory is returned as a Future.
      .then((Directory directory) {
    print('Path of New Dir: ' + directory.path);
  });

  var path = appDocDirectory.path;
  Hive
    ..init(path)
    ..registerAdapter(ContactAdapter());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Center(
                child: Image( image: AssetImage("assets/logo.png"))
              // "StalkTracker",
              // style: TextStyle(
              //   color: Colors.white70,
              //   fontWeight: FontWeight.bold,
              //   fontSize: 29,
              // ),
        //    )
        ),
            duration: 3000,
            splashTransition: SplashTransition.decoratedBoxTransition,
            backgroundColor: Colors.grey.shade900,
            nextScreen: loginpage()),
      ),
    );
  }
}

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return loginpagetest(context);
  }

  Scaffold loginpagetest(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Home', //ERA LOGIN
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: maindrawer(context),
        body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 350,
                          child:
                          Column(
                              children: [
                                Text("Welcome to StalkTracker", style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                SizedBox( height:200, width:150 , child:Image(image: AssetImage("assets/logo.png")))
                              ]
                          )
                      ),
                      // SizedBox(
                      //   height: 230,
                      // ),
                  FloatingActionButton.extended(
                    heroTag: "2",
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signuppage(),
                          ));
                    },
                    label: Text('Sign Up'),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      controller.login(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                    ),
                    label: Text('Sign In With Google'),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signinpage(),
                            ));
                      },
                      child: Text(
                        'Have an account? login',
                        style: TextStyle(color: Colors.white),
                      )),
                ]))));
  }
}
