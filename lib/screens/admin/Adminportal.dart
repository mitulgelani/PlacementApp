import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:placementapp/screens/student/Postinfo.dart';
import 'package:flutter/material.dart';
import 'package:placementapp/screens/admin/Adminpost.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class AdminPortal extends StatefulWidget {
  final FirebaseUser user;
  const AdminPortal({Key key, this.user}) : super(key: key);

  @override
  _AdminPortalState createState() => _AdminPortalState(user);
}

class _AdminPortalState extends State<AdminPortal> {
  final FirebaseUser user;
  _AdminPortalState(this.user);

  Future getdata() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('admin').getDocuments();
    doc = result.documents;
    return doc;
  }
  List<DocumentSnapshot> doc;

  showAlertDialog(BuildContext context) {
    // set up the button
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.amber,
      title: Text(""),
      content: Text("This is my message."),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {},
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Tooltip(
          message: 'add Task',
          textStyle: TextStyle(fontSize: 15, color: Colors.white),
          child: new FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPost()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: new BottomAppBar(
          color: Colors.white,
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
        ));
  }
}
