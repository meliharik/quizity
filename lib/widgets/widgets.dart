import 'package:flutter/material.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/signin.dart';

Widget appBar(BuildContext context){
  return AppBar(
    backgroundColor: customBackground,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
      onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Categories(),
        ));
      },),
    title: Row(
      children: <Widget>[
        Hero(
          tag: 'IconTag',
          child: Image.asset('assets/images/logo.png',
            height: MediaQuery.of(context).size.height * ( 1 / 10),
            width: MediaQuery.of(context).size.width * ( 1.4 / 10),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text('Quizity',style: TextStyle(
            fontFamily: 'Literata',
            fontSize: 28,
            color: Colors.white,
          ),),
        ),
      ],
    ),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    height: 50,
    alignment: Alignment.center,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [customPink,customBlue],
        ),
        borderRadius: BorderRadius.circular(30)
    ),
    child: Text(label,style: TextStyle(
      color: Colors.white, fontSize: 16,
    ),),
  );
}

