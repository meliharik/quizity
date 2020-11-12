import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizity/models/question_model.dart';
import 'package:quizity/screens/result.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/database.dart';
import 'package:quizity/widgets/quiz_play_widget.dart';
import 'package:quizity/widgets/widgets.dart';

import 'categories.dart';

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
Stream infoStream;

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataQuiz(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayFilm extends StatefulWidget {

  final String quizId;
  PlayFilm(this.quizId);

  @override
  _PlayFilmState createState() => _PlayFilmState();
}

class _PlayFilmState extends State<PlayFilm> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataFilm(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayScience extends StatefulWidget {

  final String quizId;
  PlayScience(this.quizId);

  @override
  _PlayScienceState createState() => _PlayScienceState();
}

class _PlayScienceState extends State<PlayScience> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataScience(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayTechnology extends StatefulWidget {

  final String quizId;
  PlayTechnology(this.quizId);

  @override
  _PlayTechnologyState createState() => _PlayTechnologyState();
}

class _PlayTechnologyState extends State<PlayTechnology> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataTechnology(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayGeography extends StatefulWidget {

  final String quizId;
  PlayGeography(this.quizId);

  @override
  _PlayGeographyState createState() => _PlayGeographyState();
}

class _PlayGeographyState extends State<PlayGeography> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataGeography(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: MediaQuery.of(context).size.width * ( 1.4/ 10),),
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlaySoftware extends StatefulWidget {

  final String quizId;
  PlaySoftware(this.quizId);

  @override
  _PlaySoftwareState createState() => _PlaySoftwareState();
}

class _PlaySoftwareState extends State<PlaySoftware> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataSoftware(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlaySports extends StatefulWidget {

  final String quizId;
  PlaySports(this.quizId);

  @override
  _PlaySportsState createState() => _PlaySportsState();
}

class _PlaySportsState extends State<PlaySports> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataSports(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: MediaQuery.of(context).size.width * ( 1.4/ 10),),
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayMusic extends StatefulWidget {

  final String quizId;
  PlayMusic(this.quizId);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataMusic(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayArt extends StatefulWidget {

  final String quizId;
  PlayArt(this.quizId);

  @override
  _PlayArtState createState() => _PlayArtState();
}

class _PlayArtState extends State<PlayArt> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataArt(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayHistory extends StatefulWidget {

  final String quizId;
  PlayHistory(this.quizId);

  @override
  _PlayHistoryState createState() => _PlayHistoryState();
}

class _PlayHistoryState extends State<PlayHistory> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataHistory(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class PlayAnimals extends StatefulWidget {

  final String quizId;
  PlayAnimals(this.quizId);

  @override
  _PlayAnimalsState createState() => _PlayAnimalsState();
}

class _PlayAnimalsState extends State<PlayAnimals> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;
  bool isLoading = true;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot){

    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizDataAnimals(widget.quizId).then((value){
      questionsSnapshot = value;
      _notAttempted = questionsSnapshot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionsSnapshot.documents.length;
      print("$total this is total");
      setState(() {});
    });
    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100),(x){
        print("this is x $x");
        return [_correct, _incorrect];
      }
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: isLoading ?
      Container(
        color: customBackground,
        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionsSnapshot.documents.length,
              ),
              SizedBox(height: 10,),
              questionsSnapshot == null ?
              Container(
                color: customBackground,
                child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(customPink),),),
              ) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: questionsSnapshot.documents.length,
                itemBuilder: (context,index){
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDatasnapshot(questionsSnapshot.documents[index]),
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPink,
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Results(
              correct: _correct,
              incorrect: _incorrect,
              total: total,
            ),
          ));
        },
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;
  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: infoStream,
      builder: (context,snapshot){
        return snapshot.hasData ? Container(
          height: 50,
          margin: EdgeInsets.only(left: 14),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              NoOfQuestionTile(
                text: "Total",
                number: widget.length,
              ),
              NoOfQuestionTile(
                text: "Correct",
                number: _correct,
              ),
              NoOfQuestionTile(
                text: "Incorrect",
                number: _incorrect,
              ),
              NoOfQuestionTile(
                text: "NotAttempted",
                number: _notAttempted,
              ),
            ],
          ),
        ) : Container();
      },
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel,this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text("Q${widget.index + 1} ${widget.questionModel.question}",style: TextStyle(
            fontSize: 17, color: Colors.white,fontFamily: 'Literata'
          ),),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 ==
                  widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = total - (_correct + _incorrect);
                  setState(() {

                  });
                } else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = total - (_correct + _incorrect);
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: 'A',
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option2 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  print("${widget.questionModel.correctOption}");
                  setState(() {});
                } else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: 'B',
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option3 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                } else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: 'C',
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                if(widget.questionModel.option4 ==
                    widget.questionModel.correctOption){
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: 'D',
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

