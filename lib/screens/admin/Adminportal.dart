import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:placementapp/screens/admin/Adminpost.dart';

class AdminPortal extends StatefulWidget {
  final FirebaseUser user;
  const AdminPortal({Key key, this.user}) : super(key: key);

  @override
  _AdminPortalState createState() => _AdminPortalState(user);
}

class _AdminPortalState extends State<AdminPortal> {
  final FirebaseUser user;
  _AdminPortalState(this.user);

  SearchBar searchBar;

  final db = Firestore.instance;
  List<DocumentSnapshot> documents;
  List<DocumentSnapshot> friends;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name, uid;

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false, _show = false;
  String searchQuery = "Search query";

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Friend Name",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 26.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              friends.clear();
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    /*  ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching)); */

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _show = true;
      searchQuery = newQuery;
      //  friendlist();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
      //    friendlist();
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  /*  Future friendlist() async {
    QuerySnapshot result;
    if(_searchQueryController.text=="")
      result=await db.collection('users').getDocuments();
    else
      result=await db.collection('users').where('name',isEqualTo:_searchQueryController.text).getDocuments();
    return result.documents;
  } 
   */

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
        // ignore: deprecated_member_use
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
                /*       String cname = snapshot.data[i]['cname'];
                String cdetail = snapshot.data[i]['cdetails'];
                // ignore: deprecated_member_use
                List<dynamic> semlist = List<dynamic>();
                // ignore: deprecated_member_use
                List<dynamic> branchlist = List<dynamic>();
                semlist = snapshot.data[i]['sem'];
                branchlist = snapshot.data[i]['branch']; */
                String url = snapshot.data[i]['cimage'];

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
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: [
                                      0.09,
                                      1
                                    ],
                                        colors: [
                                      Colors.black,
                                      Colors.transparent
                                    ])),
                              ),
                            ]),
                      Column(
                        children: [
                          SizedBox(height: 100),
                          Container(
                            child: Text('Company:\n',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white)),
                          ),
                          Container(
                            child: Text('Company Details:\n',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Colors.white)),
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
