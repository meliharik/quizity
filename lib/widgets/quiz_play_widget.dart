import 'package:flutter/material.dart';
import 'package:quizity/screens/signin.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile({@required this.optionSelected, @required this.correctAnswer, @required this.description, @required this.option});

  @override
  _OptionTileState createState() => _OptionTileState();
}

/*class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * (0.7/10),
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.description == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ?
                  Colors.green : Colors.red : Colors.blue, width: 1.4
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text('${widget.option}',style: TextStyle(
              color: widget.optionSelected == widget.description ?
               widget.correctAnswer == widget.optionSelected ? Colors.green :
                   Colors.red : Colors.white,
            ),),
          ),
          SizedBox(width: 8,),
          Text(widget.description,style: TextStyle(fontSize: 16, color: Colors.white,),),
        ],
      )
    );
  }
}*/

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Container(
            child: Center(child: Text(widget.description,style: TextStyle(fontSize: 16, color: Colors.white,),textAlign: TextAlign.center,)),
            width: MediaQuery.of(context).size.width * (7/10),
            height: MediaQuery.of(context).size.height * (1/10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: widget.description == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ?
            Colors.blue : customPink : customBlue,
            ),
          ),
        )
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({this.text, this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)
                ),
                color: customPink,
            ),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: customBlue,
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

