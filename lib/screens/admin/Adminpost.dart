import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class AdminPost extends StatefulWidget {
  const AdminPost({Key key}) : super(key: key);

  @override
  _AdminPostState createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  final db = Firestore.instance;
  int i;
  Map<String, String> bl = HashMap<String, String>();
  Map<String, String> sl = HashMap<String, String>();
  TextEditingController bn = TextEditingController();
  TextEditingController cn = TextEditingController();
  TextEditingController sn = TextEditingController();
  TextEditingController compn = TextEditingController();
  TextEditingController mrpn = TextEditingController();
  TextEditingController mrname = TextEditingController();
  TextEditingController mrnum = TextEditingController();
  TextEditingController quan = TextEditingController();
  TextEditingController placen = TextEditingController();
  String sem, branch;
  int tap = 0;
  File _image1;
  String url1;
  var uuid = Uuid();
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<String> uploadImage() async {
    final StorageReference postImageRef = FirebaseStorage.instance
        .ref()
        .child('gs://placementapp-b2e98.appspot.com');

    var timeKey = new DateTime.now();

    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(_image1);

    // ignore: non_constant_identifier_names
    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url1 = ImageUrl.toString();
    uploaddata();
  }

  uploaddata() async {
    Map<String, dynamic> data = HashMap<String, dynamic>();
    List<String> slist = List<String>();
    List<String> blist = List<String>();
    data['brand'] = bn.text;
    data['contain'] = cn.text;
    for (String key in sl.keys) {
      slist.add(sl[key]);
    }
    data['uuid'] = uuid.v1();
    data['form'] = slist;
    data['strength'] = sn.text;
    data['company'] = compn.text;
    data['mrp'] = mrpn.text;
    data['mrname'] = mrname.text;
    data['mrnumber'] = mrnum.text;
    data['date'] = selectedDate;
    data['quantity'] = quan.text;
    data['place'] = placen.text;
    data['cimage'] = url1;

    db.collection('admin').add(data);
  }

  List<Map<String, double>> rolepackage = List<HashMap<String, double>>();

  Future getImage1() async {
    // ignore: deprecated_member_use
    final Image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 75);
    setState(() {
      _image1 = Image;
      tap++;
    });
  }

  Widget form() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(children: <Widget>[
          Text(" FORM ",
              style: TextStyle(
                fontSize: 23,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    //color: Colors.blue[100],
                    border: Border.all(
                      width: 0.3,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(0),
                    shadowColor: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    DropdownButton(
                                      items: [
                                        DropdownMenuItem(
                                            value: "susp",
                                            child: Center(
                                              child: Text("SUSP",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "tab",
                                            child: Center(
                                              child: Text("TAB",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "drops",
                                            child: Center(
                                              child: Text("DROPS",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "sup",
                                            child: Center(
                                              child: Text("SUP",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "inj",
                                            child: Center(
                                              child: Text("INJ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                      ],
                                      onChanged: (_value) {
                                        setState(() {
                                          if (sl[_value] == _value) {
                                            sl.remove(_value);
                                          } else {
                                            sl[_value] = _value;
                                          }
                                          //csc.text = _value;
                                        });
                                      },
                                      hint: Text(" Select A FORM ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          )),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Flexible(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                      ),
                                      child: new Text(
                                        '${sl.values}',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )))
        ]));
  }

  initState() {
    super.initState();
    i = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          floatingActionButton: Tooltip(
            message: 'add image',
            textStyle: TextStyle(fontSize: 15, color: Colors.white),
            child: new FloatingActionButton(
              onPressed: () {
                if (tap == 0) {
                  getImage1();
                } else {
                  Fluttertoast.showToast(
                    msg: "only one image allowed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
              child: const Icon(Icons.image),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          bottomNavigationBar: new BottomAppBar(
            color: Colors.white,
          ),
          appBar: AppBar(
            //automaticallyImplyLeading: false,
            backgroundColor: Colors.blue[300],
            title: Text(
              "Company Details",
              style: GoogleFonts.pattaya(fontSize: 30),
            ),
            centerTitle: true,
            elevation: 10,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: bn,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "Enter BRAND Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: cn,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "CONTAIN",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  /////////////////////////////////
                  Container(
                      child: _image1 == null
                          ? Container()
                          : Column(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.0, right: 5.0, top: 5.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            ' Image',
                                            style: TextStyle(
                                              fontSize: 23.0,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              // SizedBox(height: 5),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Image.file(
                                            _image1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.91,
                                            height: 350,
                                          ),
                                        ));
                                      })),
                            ])),

                  SizedBox(height: 30),
                  //Branch(),
                  form(),

                  SizedBox(height: 10),

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: sn,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "STRENGTH",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: compn,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "COMPANY",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ),

                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: mrpn,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "MRP",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: mrname,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "MR. Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: mrnum,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "MR's Number",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                        fontSize: 55,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),

                  RaisedButton(
                    onPressed: () => _selectDate(context), // Refer step 3
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.greenAccent,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: quan,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "QUANTITY",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      controller: placen,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: new InputDecoration(
                        labelText: "PLACE",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: RaisedButton(
                        onPressed: () {
                          uploadImage();
                          Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                        child: Text(
                          "POST",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
