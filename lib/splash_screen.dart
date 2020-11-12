import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizity/helper/functions.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/signin.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isLoggedin = false;

  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedin = value;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    checkUserLoggedInStatus();
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => (_isLoggedin ?? false ) ? Categories() : SignIn(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: customBackground,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'IconTag',
                    child: Image.asset('assets/images/logo.png',height: MediaQuery.of(context).size.height * (1.6/10),)),
                Shimmer.fromColors(
                  baseColor: Color(0xff5700ed),
                  highlightColor: customPink,
                  child: Container(
                    child: Text('Quizity',style: TextStyle(
                      fontFamily: 'Literata',
                      fontSize: 35,
                      color: Colors.white,
                    ),),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}