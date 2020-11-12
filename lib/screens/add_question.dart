import 'package:flutter/material.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/database.dart';
import 'package:quizity/widgets/widgets.dart';

class AddQuestionQuiz extends StatefulWidget {
  final String quizId;

  AddQuestionQuiz(this.quizId);

  @override
  _AddQuestionQuizState createState() => _AddQuestionQuizState();
}

class _AddQuestionQuizState extends State<AddQuestionQuiz> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataQuiz(questionMap, widget.quizId)
      .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Quiz',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionFilm extends StatefulWidget {
  final String quizId;
  AddQuestionFilm(this.quizId);
  @override
  _AddQuestionFilmState createState() => _AddQuestionFilmState();
}

class _AddQuestionFilmState extends State<AddQuestionFilm> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataFilm(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Movie',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionScience extends StatefulWidget {
  final String quizId;
  AddQuestionScience(this.quizId);
  @override
  _AddQuestionScienceState createState() => _AddQuestionScienceState();
}

class _AddQuestionScienceState extends State<AddQuestionScience> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataScience(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Science',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionTechnology extends StatefulWidget {
  final String quizId;
  AddQuestionTechnology(this.quizId);
  @override
  _AddQuestionTechnologyState createState() => _AddQuestionTechnologyState();
}

class _AddQuestionTechnologyState extends State<AddQuestionTechnology> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataTechnology(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Technology',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionGeography extends StatefulWidget {
  final String quizId;
  AddQuestionGeography(this.quizId);
  @override
  _AddQuestionGeographyState createState() => _AddQuestionGeographyState();
}

class _AddQuestionGeographyState extends State<AddQuestionGeography> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataGeography(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Geography',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionSoftware extends StatefulWidget {
  final String quizId;
  AddQuestionSoftware(this.quizId);
  @override
  _AddQuestionSoftwareState createState() => _AddQuestionSoftwareState();
}

class _AddQuestionSoftwareState extends State<AddQuestionSoftware> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataSoftware(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Software',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionSports extends StatefulWidget {
  final String quizId;
  AddQuestionSports(this.quizId);
  @override
  _AddQuestionSportsState createState() => _AddQuestionSportsState();
}

class _AddQuestionSportsState extends State<AddQuestionSports> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataSports(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Sports',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionMusic extends StatefulWidget {
  final String quizId;
  AddQuestionMusic(this.quizId);
  @override
  _AddQuestionMusicState createState() => _AddQuestionMusicState();
}

class _AddQuestionMusicState extends State<AddQuestionMusic> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataMusic(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Music',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionArt extends StatefulWidget {
  final String quizId;
  AddQuestionArt(this.quizId);
  @override
  _AddQuestionArtState createState() => _AddQuestionArtState();
}

class _AddQuestionArtState extends State<AddQuestionArt> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataArt(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Art',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionHistory extends StatefulWidget {
  final String quizId;
  AddQuestionHistory(this.quizId);
  @override
  _AddQuestionHistoryState createState() => _AddQuestionHistoryState();
}

class _AddQuestionHistoryState extends State<AddQuestionHistory> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataHistory(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('History',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class AddQuestionAnimals extends StatefulWidget {
  final String quizId;
  AddQuestionAnimals(this.quizId);
  @override
  _AddQuestionAnimalsState createState() => _AddQuestionAnimalsState();
}

class _AddQuestionAnimalsState extends State<AddQuestionAnimals> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });
      Map<String,String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
      await databaseService.addQuestionDataAnimals(questionMap, widget.quizId)
          .then((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackground,
      resizeToAvoidBottomInset: false,
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
              child: Text('Animal',style: TextStyle(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * (0.69/10),),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Question",
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option1 (Correct Answer)",
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option2",
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option3",
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: customPink),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Option4",
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text('*NOTE THAT:',style: TextStyle(color: Colors.white,fontSize: 17,),textAlign: TextAlign.start,),
              ),
              Text("Press Add Question button after added question. If you press submit button directly, your question won't be saved!",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.start,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: 'Submit',
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                    ),
                  ),
                  SizedBox(width: 24,),
                  Builder(
                    builder:(context) => GestureDetector(
                      onTap: (){
                        uploadQuestionData();
                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Question Added Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: blueButton(
                        context: context,
                        label: 'Add Question',
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}