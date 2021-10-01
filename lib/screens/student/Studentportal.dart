import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:placementapp/pages/Loginscreen.dart';
import 'package:placementapp/screens/student/Postinfo.dart';
import 'package:placementapp/screens/student/Studentprofile.dart';
import 'package:placementapp/main.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Studenthome.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:placementapp/screens/student/Interested.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:placementapp/screens/student/Postinfo.dart';

class Studentportal extends StatefulWidget {
  final FirebaseUser user;

  const Studentportal({Key key, this.user}) : super(key: key);

  @override
  _StudentportalState createState() => _StudentportalState();
}

class _StudentportalState extends State<Studentportal> {
  List<DocumentSnapshot> doc;
  Future getdata() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('admin').getDocuments();
    doc = result.documents;
    return doc;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Companies",
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
        body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                String cname = snapshot.data[i]['cname'];
                String cdetail = snapshot.data[i]['cdetails'];
                String url = snapshot.data[i]['cimage'];
                // ignore: deprecated_member_use
                List<dynamic> semlist = List<dynamic>();
                // ignore: deprecated_member_use
                List<dynamic> branchlist = List<dynamic>();
                semlist = snapshot.data[i]['sem'];
                branchlist = snapshot.data[i]['branch'];

                return Card(
                  elevation: 5,
                  child: Stack(
                    children: <Widget>[
                      url == null
                          ? Container()
                          : Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(url,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    fit: BoxFit.fill),
                              ),
                            ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //ui of post
                          GestureDetector(
                            child: ListTile(
                              title: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.width * 0.50,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage("$url"),
                                  ),
                                ),
                              ),
                              subtitle: ListTile(
                                //expandedAlignment: Alignment.center,
                                //backgroundColor: Colors.amber,
                                title: Text(
                                  '$cname',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 25.0,
                                  ),
                                ),
                                subtitle: Text(
                                  "Mon 10 Jun 2021",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Map<String, dynamic> list =
                                  Map<String, dynamic>();
                              list['canme'] = snapshot.data[i]['cname'];
                              list['cdetails'] = cdetail;
                              list['sem'] = semlist;
                              list['branch'] = branchlist;

                              print("----");
                              print(list);
                              print("----");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Postinfo(list: list)));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        )
        /*FutureBuilder<dynamic>(
        future: getdata(), // async work
        builder: /* (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Text('shkjsh');
        }, */
      ), */
        /*    SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            //gradient: FlutterGradients.newYork(),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: ImageSlideshow(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.45,
                        initialPage: 0,
                        indicatorColor: Colors.orange[300],
                        indicatorBackgroundColor: Colors.white,
                        children: [
                          ClipRect(
                            child: Image.asset(
                              'assets/tcs.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/mg.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/ril.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/lnt.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/worley.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                        autoPlayInterval: 3000,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,

                    gradient: FlutterGradients.leCocktail(), //flyingLemon(),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      "\t\t\t\t\t\t \t\tRecent Posts",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //ui of post
                        /* GestureDetector(
                          child:  ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.width * 0.50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage("assets/tcs.png"),
                              ),
                            ),
                          ),
                          subtitle: ListTile(
                            //expandedAlignment: Alignment.center,
                            //backgroundColor: Colors.amber,
                            title: Text(
                              'Tata Consultancy Services',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                              ),
                            ),
                            subtitle: Text(
                              "Mon 10 Jun 2021",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ), 
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Postinfo()));
                          },
                        ),                */
                       
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), */
        );
  }
}
