import 'package:quizity/animation/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:quizity/helper/functions.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/home.dart';
import 'package:quizity/screens/signup.dart';
import 'package:quizity/services/auth.dart';
import 'package:quizity/widgets/widgets.dart';

Color customBackground = Color(0xff21254B);
Color customBlue = Color(0xff5700ed).withOpacity(0.4);
Color customPink = Color(0xffff15b2);


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = AuthService();
  bool _isLoading = false;

  signIn() async {
    if(_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
        try{
          await authService.signInEmailandPass(email, password).then((val){
            if(val != null){
            setState(() {
              _isLoading = false;
            });
            HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Categories(),
            ));
          }else{
              showDialog(
                  barrierDismissible: false,
                  context: context,builder: (context){
                return AlertDialog( backgroundColor: customBackground,
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 40,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Something went wrong. Please try again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              }
              );
            }
          });
        }catch(err){
          showDialog(context: context,builder: (context){
            return AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                      'Bir hata oluştu. Tekrar deneyiniz.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          }
          );
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * (3 / 10),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Hero(
                          tag: 'IconTag',
                          child: Image.asset("assets/images/logo.png",height: MediaQuery.of(context).size.height * (1.5/10),)),
                      FadeAnimation(
                        1,
                        Text('Quizity',style: TextStyle(
                          fontFamily: 'Literata',
                          fontSize: 35,
                          color: Colors.white,
                        ),),
                      )
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      2,
                      Text(
                        "Hello there, \nwelcome back",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //SizedBox(height: 40,),
                    FadeAnimation(
                      3,
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  validator: (val){return val.isEmpty ? 'Enter an email' : null;},
                                  onChanged: (val){
                                    val = val.trim();
                                    email = val;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  validator: (val){return val.length < 6 ? 'Password must be least 6 character' : null;},
                                  onChanged: (val){
                                    val = val.trim();
                                    password = val;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: customPink,
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * (0.5/10)),
                    FadeAnimation(
                      3,
                      GestureDetector(
                        onTap: (){
                          signIn();
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: customBlue,
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FadeAnimation(
                      3,
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: customPink,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}