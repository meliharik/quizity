import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/screens/signup.dart';

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Literata',
  fontSize: 26.0,
  height: 1.5,
  fontWeight: FontWeight.bold
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : customBlue,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                customBackground,
                customBackground,
                customBackground,
                customBackground,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*(1.3/10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left:20,top: 20),
                        height: MediaQuery.of(context).size.height*(1/10),
                        width: MediaQuery.of(context).size.width*(2/10),
                        child: Hero(
                          tag: 'IconTag',
                            child: FadeAnimation(1,Image.asset('assets/images/logo.png'))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:20,top: 20),
                        child: FlatButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => SignIn()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * (1/10),),
                Container(
                  height: MediaQuery.of(context).size.height * (6.6/10),
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding1.png',
                                ),
                                height: MediaQuery.of(context).size.height * (3/10),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Play Illustrated Quizzes',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Play and add unique Quizzes.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding2.png',
                                ),
                                height: MediaQuery.of(context).size.height * (3/10),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Examine your results',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'You can share your results or try again.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboarding3.png',
                                ),
                                height: MediaQuery.of(context).size.height * (3/10),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Learn fun facts',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Upload and answer questions that makes you a genious :)',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => SignIn()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
        height: MediaQuery.of(context).size.height * (1.3/10),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Color(0xFF283593),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ),
      ),
          )
          : Text(''),
    );
  }
}