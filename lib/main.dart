import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizity/helper/functions.dart';
import 'package:quizity/screens/home.dart';
import 'package:quizity/screens/onboarding.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  //print('initScreen ${initScreen}');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedin = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }
  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState(() {
        _isLoggedin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizity',
      theme: ThemeData(
        cursorColor: customPink,
      ),
      home: initScreen == 0 || initScreen == null ? OnboardingScreen() : SplashScreen(),
    );
  }
}
