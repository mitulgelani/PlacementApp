import 'package:flutter/material.dart';
import 'package:placementapp/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:placementapp/pages/Signupscreen.dart';
import 'package:placementapp/pages/Forgotpassword.dart';
import 'package:placementapp/pages/AdminLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placementapp/screens/admin/Adminhome.dart';
import 'package:placementapp/controllers/authentications.dart';


class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();


   void login() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signIn(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(uid: value.uid),
              ));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[500],
          title: Text(
            "Placement App",
            style: GoogleFonts.pattaya(fontSize:30),
          ),
          centerTitle: true,
          elevation: 10,
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Login Here!",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email:"),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "This is a required field"),
                          EmailValidator(errorText: "Invalid Email Address"),
                        ]),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password:"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Password is required"),
                            MinLengthValidator(6,
                                errorText: "Minimum 6 characters are required"),
                          ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgotpassword()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: login,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("or Login as Admin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminLogin()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  "Don't have an account?\n\t\t\t\t\t\t\t\t\t\tSignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0))),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signupscreen()));
                          },
                        ),
                      ),
                    ],
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
