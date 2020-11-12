import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/categories/animals.dart';
import 'package:quizity/categories/art.dart';
import 'package:quizity/categories/film.dart';
import 'package:quizity/categories/geography.dart';
import 'package:quizity/categories/history.dart';
import 'package:quizity/categories/music.dart';
import 'package:quizity/categories/science.dart';
import 'package:quizity/categories/software.dart';
import 'package:quizity/categories/sports.dart';
import 'package:quizity/categories/technology.dart';
import 'package:quizity/helper/functions.dart';
import 'package:quizity/models/user.dart';
import 'package:quizity/screens/about_me.dart';
import 'package:quizity/screens/home.dart';
import 'package:quizity/screens/onboarding.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/auth.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  String email, password;
  AuthService authService = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  signOut() async {
      await authService.signOut().then((val){
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => OnboardingScreen(),
          ));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _drawer,
      appBar: AppBar(
        backgroundColor: customBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              _scaffoldKey.currentState.openEndDrawer();
            },
          )
        ],
      ),
      backgroundColor: customBackground,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * (1.5 / 10),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Are you Ready?',style: TextStyle(
                              color: customPink,
                              fontFamily: 'Literata',
                              fontSize: 25
                          ),),
                          Text('Challange your limits!',style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Literata',
                              fontSize: 20
                          ),)
                        ],
                      )),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 1/2,
                    child: Column(
                     children: <Widget>[
                       FadeAnimation(
                         1,GestureDetector(
                           onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                               builder: (context) => Film(),
                             ));
                           },
                           child: Container(
                             margin: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width * (1/2),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset('assets/images/film.png',height: MediaQuery.of(context).size.height * (1.4/10),),
                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: Text('Movies & Series',style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 20,
                                     fontFamily: 'Literata'
                                   ),),
                                 )
                               ],
                             ),
                             height: 225,
                             decoration: BoxDecoration(
                                 color: Colors.grey.withOpacity(0.7),
                                 borderRadius: BorderRadius.all(Radius.circular(15))
                             ),
                           ),
                         ),
                       ),
                       FadeAnimation(
                         2,GestureDetector(
                           onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                               builder: (context) => Science(),
                             ));
                           },
                           child: Container(
                             margin: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width * (1/2),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset('assets/images/science.png',
                                   height: MediaQuery.of(context).size.height * (1.4/10),),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Science',style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontFamily: 'Literata'
                                   ),),
                                 )
                               ],
                             ),
                             height: 200,
                             decoration: BoxDecoration(
                                 color: Colors.grey.withOpacity(0.7),
                                 borderRadius: BorderRadius.all(Radius.circular(15))
                             ),
                           ),
                         ),
                       ),
                       FadeAnimation(
                         3,GestureDetector(
                           onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                               builder: (context) => Technology(),
                             ));
                           },
                           child: Container(
                             margin: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width * (1/2),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset('assets/images/technology.png',height: MediaQuery.of(context).size.height * (1.7/10),),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Technology',style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontFamily: 'Literata'
                                   ),),
                                 )

                               ],
                             ),
                             height: 200,
                             decoration: BoxDecoration(
                                 color: Colors.grey.withOpacity(0.7),
                                 borderRadius: BorderRadius.all(Radius.circular(15))
                             ),
                           ),
                         ),
                       ),
                       FadeAnimation(
                         4,GestureDetector(
                           onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                               builder: (context) => Geography(),
                             ));
                           },
                           child: Container(
                             margin: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width * (1/2),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset('assets/images/geography.png',height: MediaQuery.of(context).size.height * (1.7/10),),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Geography',style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontFamily: 'Literata'
                                   ),),
                                 )
                               ],
                             ),
                             height: 225,
                             decoration: BoxDecoration(
                                 color: Colors.grey.withOpacity(0.7),
                                 borderRadius: BorderRadius.all(Radius.circular(15))
                             ),
                           ),
                         ),
                       ),
                       FadeAnimation(
                         5,GestureDetector(
                           onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(
                               builder: (context) => Software(),
                             ));
                           },
                           child: Container(
                             margin: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width * (1/2),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Image.asset('assets/images/software.png',height: MediaQuery.of(context).size.height * (1.7/10),),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Software',style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 20,
                                       fontFamily: 'Literata'
                                   ),),
                                 )
                               ],
                             ),
                             height: 200,
                             decoration: BoxDecoration(
                                 color: Colors.grey.withOpacity(0.7),
                                 borderRadius: BorderRadius.all(Radius.circular(15))
                             ),
                           ),
                         ),
                       ),
                     ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1/2,
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                          1,GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Sports(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * (1/2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/sports.png',height: MediaQuery.of(context).size.height * (1.5/10),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Sports',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Literata'
                                    ),),
                                  )
                                ],
                              ),
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          2,GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Music(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * (1/2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/music.png',height: MediaQuery.of(context).size.height * (1.7/10),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Music',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Literata'
                                    ),),
                                  )
                                ],
                              ),
                              height: 225,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          3,GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Art(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * (1/2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/art.png',height: MediaQuery.of(context).size.height * (1.5/10),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Art',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Literata'
                                    ),),
                                  )
                                ],
                              ),
                              height: 225,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          4,GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => History(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * (1/2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/history.png',height: MediaQuery.of(context).size.height * (1.4/10),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('History',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Literata'
                                    ),),
                                  )
                                ],
                              ),
                              height: 175,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                            ),
                          ),
                        ),
                        FadeAnimation(
                          5, GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Animals(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * (1/2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset('assets/images/animals.png',height: MediaQuery.of(context).size.height * (1.7/10),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Animals',style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Literata'
                                    ),),
                                  )
                                ],
                              ),
                              height: 225,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      )
    );
  }

  Widget get _drawer => Drawer(
    child: Container(
      color: customBackground,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * (1 / 10),),
          Container(
            child: ListTile(
              leading: Icon(Icons.exit_to_app,size: 30,color: Colors.white,),
              title: Text('Sign Out', style: TextStyle(color: Colors.white,fontSize: 17),),
              onTap: () => {
                signOut(),
              },
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.info_outline,size: 28,color: Colors.white,),
              title: Text('About me', style: TextStyle(color: Colors.white,fontSize: 17),),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => AboutMe(),
                ));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

/*
onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => Home()));
              },
 */
