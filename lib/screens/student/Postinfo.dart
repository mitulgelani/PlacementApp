import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementapp/screens/student/Studentprofile.dart';
import 'package:placementapp/screens/student/Studentportal.dart';
import 'package:placementapp/main.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Studenthome.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:placementapp/screens/student/Interested.dart';

class Postinfo extends StatefulWidget {
  Map<String, dynamic> list = Map<String, dynamic>();
  Postinfo({Key key, this.list}) : super(key: key);

  @override
  _PostinfoState createState() => _PostinfoState(list);
}

class _PostinfoState extends State<Postinfo> {
  Map<String, dynamic> list = Map<String, dynamic>();
  _PostinfoState(this.list);
  void initState() {
    super.initState();
    print("-//-");
    print(list);
    print("-//-");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          '',
          style: GoogleFonts.courgette(
            textStyle: TextStyle(
              fontSize: 29,
              color: Colors.orange[300],
            ),
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 2,
                color: Colors.orange[300],
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    list['cdetails'],
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    ' ${list['branch']} ',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Students who can apply: ${list['sem']} \n ",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Role(s) on offer: Software developer, Quality Assurance",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Salary Packages for respective role(s) : 4LPA, 3LPA",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Criteria: Only the students above 7.0 CPI should apply\nNo backlogs or Remedials",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "*Deadline to apply: 23/09/2021*",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Interested()),
                    );
                  },
                  color: Colors.yellow,
                  child: Text(
                    "Interested",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
