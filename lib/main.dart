import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placementapp/pages/Loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Placement App",
        theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: GoogleFonts.darkerGrotesqueTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.darkerGrotesqueTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: HomePage(),
     );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){

              },
              child: Text(
                "Login Screen"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
