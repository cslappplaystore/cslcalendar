import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'cslCalendar.dart';

void main() {
   //initializeDateFormatting('en_IN', null).then((_) => 
   runApp(MyApp());
   //);
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'संवृद्धि\nSamvridhi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HP Simplified Bold'
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override 
  initState(){
    super.initState();
    Timer(Duration(seconds: 5), ()=>Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                        return cslCalendar();
                                      }
    )));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: new Image.asset('images/calendar-splash.png'),
      ),
    );
  }
}