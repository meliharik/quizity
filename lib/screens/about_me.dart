import 'package:flutter/material.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/signin.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Categories(),
        ));
      },
      child: Scaffold(
        appBar: AppBar(
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
                  width: MediaQuery.of(context).size.width * ( 1.6 / 10),),
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
        ),
        backgroundColor: customBackground,
        body: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * (1.7/10),),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      2,Container(
                        child: Image.asset('assets/images/melih2.png'),
                        height: MediaQuery.of(context).size.height * (2/10),
                        width: MediaQuery.of(context).size.width * (3/10),
                      ),
                    ),
                    FadeAnimation(
                      1,Text('Melih Arık',style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Literata',
                      ),),
                    ),
                    FadeAnimation(
                      1,Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text('This is my first app on Google Play. Thank you for download and support me. Don\'t forget to give 5 stars. I design and code the future.',style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Literata',
                        ),),
                      ),
                    ),
                    FadeAnimation(
                      3,Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          child: Text('meliharik.ml',style: TextStyle(fontSize: 20,color: Colors.blue.withOpacity(0.8),fontFamily: 'Literata', fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          onTap: () async {
                            if (await canLaunch("https://meliharik.ml/")) {
                              await launch("https://meliharik.ml/");
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
