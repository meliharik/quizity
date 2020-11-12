import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:quizity/animation/fade_animation.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/database.dart';
import 'package:quizity/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

import 'add_question.dart';
import 'categories.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataQuiz(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionQuiz(
            quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateFilm extends StatefulWidget {
  @override
  _CreateFilmState createState() => _CreateFilmState();
}

class _CreateFilmState extends State<CreateFilm> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataFilm(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionFilm(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateScience extends StatefulWidget {
  @override
  _CreateScienceState createState() => _CreateScienceState();
}

class _CreateScienceState extends State<CreateScience> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataScience(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionScience(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateTechnology extends StatefulWidget {
  @override
  _CreateTechnologyState createState() => _CreateTechnologyState();
}

class _CreateTechnologyState extends State<CreateTechnology> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataTechnology(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionTechnology(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateGeography extends StatefulWidget {
  @override
  _CreateGeographyState createState() => _CreateGeographyState();
}

class _CreateGeographyState extends State<CreateGeography> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataGeography(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionGeography(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateSoftware extends StatefulWidget {
  @override
  _CreateSoftwareState createState() => _CreateSoftwareState();
}

class _CreateSoftwareState extends State<CreateSoftware> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataSoftware(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionSoftware(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateSports extends StatefulWidget {
  @override
  _CreateSportsState createState() => _CreateSportsState();
}

class _CreateSportsState extends State<CreateSports> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataSports(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionSports(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateMusic extends StatefulWidget {
  @override
  _CreateMusicState createState() => _CreateMusicState();
}

class _CreateMusicState extends State<CreateMusic> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataMusic(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionMusic(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateArt extends StatefulWidget {
  @override
  _CreateArtState createState() => _CreateArtState();
}

class _CreateArtState extends State<CreateArt> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataArt(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionArt(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateHistory extends StatefulWidget {
  @override
  _CreateHistoryState createState() => _CreateHistoryState();
}

class _CreateHistoryState extends State<CreateHistory> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataHistory(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionHistory(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateAnimals extends StatefulWidget {
  @override
  _CreateAnimalsState createState() => _CreateAnimalsState();
}

class _CreateAnimalsState extends State<CreateAnimals> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String,String> quizMap = {
        "quizId" : quizId,
        "quizImgurl" : quizImageUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };

      await databaseService.addQuizDataAnimals(quizMap, quizId).then((value){
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestionAnimals(
              quizId
          )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: customBackground,
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
              child: Text('Quizity',style: TextStyle(
                fontFamily: 'Literata',
                fontSize: 28,
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
      body: _isLoading ? Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FadeAnimation(1,
            Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (2/10),),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Image Url",
                  ),
                  onChanged: (val){
                    val = val.trim();
                    quizImageUrl = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Title",
                  ),
                  onChanged: (val){
                    quizTitle = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: customBlue)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customPink),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Quiz Description",
                  ),
                  onChanged: (val){
                    quizDescription = val;
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: blueButton(context:context, label: "Create Quiz"),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}