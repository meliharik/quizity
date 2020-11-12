import 'package:flutter/material.dart';
import 'package:quizity/screens/categories.dart';
import 'package:quizity/screens/create_quiz.dart';
import 'package:quizity/screens/play_quiz.dart';
import 'package:quizity/screens/signin.dart';
import 'package:quizity/services/database.dart';
import 'package:quizity/widgets/widgets.dart';

class Science extends StatefulWidget {
  @override
  _ScienceState createState() => _ScienceState();
}

class _ScienceState extends State<Science> {

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot.data == null
              ? Container():
          ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return
                  QuizTile(
                    imgUrl: snapshot.data.documents[index].data["quizImgurl"],
                    desc: snapshot.data.documents[index].data["quizDesc"],
                    title: snapshot.data.documents[index].data["quizTitle"],
                    quizId: snapshot.data.documents[index].data["quizId"],
                  );
              });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizezDataScience().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Categories(),
        ));
      },
      child: Scaffold(
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
                child: Text('Science',style: TextStyle(
                  fontFamily: 'Literata',
                  fontSize: 28,
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
        body: quizList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffff15b2).withOpacity(0.8),
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateScience(),
            ));
          },
        ),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;
  QuizTile({@required this.imgUrl, @required this.title, @required this.desc, @required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayScience(
                quizId
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8,top: 8),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl,width: MediaQuery.of(context).size.width-48,fit: BoxFit.cover,)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title,style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.w600),),
                  SizedBox(height: 6,),
                  Text(desc,style: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
