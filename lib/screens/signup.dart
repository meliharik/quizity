import 'package:flutter/material.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/home.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/auth.dart';
import 'package:quizity/widgets/widgets.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email, password, name;
  AuthService authService = AuthService();
  bool _isLoading = false;

  signUp(){
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then(
              (value) {
            if(value != null){
              setState(() {
                _isLoading = false;
              });
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => Categories()
              ));
            } else {
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
                          builder: (context) => SignUp(),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => SignIn(),
        ));
      },
      child: Scaffold(
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
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                            tag: 'IconTag',
                            child: Image.asset("assets/images/logo.png",height: MediaQuery.of(context).size.height * (1.8/10),)),
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
                        1,
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
                                    validator: (val){return val.isEmpty ? 'Enter a name' : null;},
                                    onChanged: (val){
                                      val = val.trim();
                                      name = val;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: 20.0,),
                      SizedBox(height: MediaQuery.of(context).size.height * (0.5 / 10)),
                      FadeAnimation(
                        2,
                        GestureDetector(
                          onTap: (){
                            signUp();
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
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      FadeAnimation(
                        2,
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => SignIn()));
                            },
                            child: Text(
                              "Already have an Account? ",
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
      ),
    );
  }
}
