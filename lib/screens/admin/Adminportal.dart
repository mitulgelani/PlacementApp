import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:placementapp/screens/admin/Adminpost.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({Key key}) : super(key: key);

  @override
  _AdminPortalState createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  Future getdata() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('admin').getDocuments();
    doc = result.documents;
    return doc;
  }

  List<DocumentSnapshot> doc;

  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
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
                List<dynamic> semlist = List<dynamic>();
                List<dynamic> branchlist = List<dynamic>();
                semlist = snapshot.data[i]['sem'];
                branchlist = snapshot.data[i]['branch'];
                return Card(
                  elevation: 5,
                  child: Stack(
                    children: <Widget>[
                      url == null
                          ? Container()
                          : Image.network(
                              url,
                            ),
                      Column(
                        children: [
                          Text('Sem:\n${semlist}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Text('Branch:\n${branchlist}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
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
