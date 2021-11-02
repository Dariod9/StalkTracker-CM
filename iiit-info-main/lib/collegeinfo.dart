import 'package:flutter/material.dart';
import 'package:hackathon/addreview.dart';
import 'package:hackathon/collegereviews.dart';

class collegeinfopage extends StatefulWidget {
  @override
  static var college_id;
  static var college_ctc;
  static var college_established;
  static var college_rank;
  static var collegename;
  static var emailid;
  State<collegeinfopage> createState() => _loginpageState();
}

void collegeinfo(var collegeid, var collegectc, var collegeestablished,
    var collegerank, var collegename, var loginmail) {
  collegeinfopage.college_id = collegeid;
  collegeinfopage.college_ctc = collegectc;
  collegeinfopage.college_established = collegeestablished;
  collegeinfopage.college_rank = collegerank;
  collegeinfopage.collegename = collegename;
  collegeinfopage.emailid = loginmail;
}

class _loginpageState extends State<collegeinfopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            collegeinfopage.college_id,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                collegeinfopage.collegename,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'NIRF Rank',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Text(
                    collegeinfopage.college_rank,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Established',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Text(
                    collegeinfopage.college_established,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Average CTC',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Text(
                    collegeinfopage.college_ctc,
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => addratingspage(),
                            ));
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      label: Text('Add/Edit Review'))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        collegeratingsinfo(collegeinfopage.college_id, context);
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      label: Text('Ratings and Reviews'))),
            ),
          ],
        ));
  }
}
