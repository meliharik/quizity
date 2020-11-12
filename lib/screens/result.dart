import 'package:flutter/material.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/widgets/widgets.dart';
import 'package:share/share.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results({@required this.correct,@required this.incorrect,@required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: MediaQuery.of(context).size.width * ( 1.4 / 10),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Results',style: TextStyle(
                  fontFamily: 'Literata',
                  fontSize: 28,
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      backgroundColor: customBackground,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.3/10),),
              FadeAnimation(
                1,Container(
                  height: MediaQuery.of(context).size.height * (4/10),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/result.png'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
              FadeAnimation(
                2,Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * (8/10),
                    child: Text('Your result is:',style: TextStyle(
                      color: Colors.white,fontSize: 20,fontFamily: 'Literata'
                    ),),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
              FadeAnimation(
                2,Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * (1/10),
                    width: MediaQuery.of(context).size.width * (8/10),
                    decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(Icons.check,color: Colors.white,),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,bottom: 3),
                                    child: Text('${widget.correct} / ${widget.total}',style: TextStyle(
                                      color: Colors.white,fontSize: 22,fontFamily: 'Literata',fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                              Text('Correct',style: TextStyle(
                                color: Colors.white70,fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: MediaQuery.of(context).size.height * (0.8/10),
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.blue,width: 2),
                                    ),
                                    height: MediaQuery.of(context).size.height * (0.4/10),
                                    width: MediaQuery.of(context).size.width * (0.6/10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,bottom: 3),
                                    child: Text('${widget.total - (widget.incorrect + widget.correct)} / ${widget.total}',style: TextStyle(
                                        color: Colors.white,fontSize: 22,fontFamily: 'Literata',fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                              Text('Skipped',style: TextStyle(
                                  color: Colors.white70,fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: MediaQuery.of(context).size.height * (0.8/10),
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(Icons.close,color: Colors.white,),
                                    decoration: BoxDecoration(
                                      color: customPink,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,bottom: 3),
                                    child: Text('${widget.incorrect} / ${widget.total}',style: TextStyle(
                                        color: Colors.white,fontSize: 22,fontFamily: 'Literata',fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                              Text('Wrong',style: TextStyle(
                                  color: Colors.white70,fontSize: 14
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
              FadeAnimation(
                6,Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * (1/10),
                    width: MediaQuery.of(context).size.width * (8/10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Categories()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * (0.8/10),
                            width: MediaQuery.of(context).size.width * (3.5/10),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Text('Try Again',style: TextStyle(
                                color: Colors.white,fontFamily: 'Literata',fontWeight: FontWeight.bold,fontSize: 20
                              ),),
                            )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: customPink,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            share(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * (0.8/10),
                            width: MediaQuery.of(context).size.width * (3.5/10),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Text('Share',style: TextStyle(
                                  color: Colors.white,fontFamily: 'Literata',fontWeight: FontWeight.bold,fontSize: 20
                              ),),
                            )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Color(0xff5700ed),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void share(BuildContext context){
    final RenderBox box = context.findRenderObject();
    final String text = "https://play.google.com/store/apps/details?id=ml.meliharik.quizity \nI've got ${widget.correct} correct in ${widget.total} questions. Let's see what you can do. Download the app.";
    
    Share.share(text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,);
  }
}




/*
Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${widget.correct} / ${widget.total}',style: TextStyle(
                  fontSize: 17
                ),),
                SizedBox(height: 8,),
                Text('You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly',style: TextStyle(
                  fontSize: 15, color: Colors.grey,
                ),textAlign: TextAlign.center,
                ),
                SizedBox(height: 14,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: blueButton(context: context,label: "Go to Home",buttonWidth: MediaQuery.of(context).size.width/2)),
              ],
            )
        ),
      ),
 */
