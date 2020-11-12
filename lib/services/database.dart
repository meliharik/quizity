import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  Future<void> addQuizDataQuiz(Map quizData, String quizId) async {
    await Firestore.instance.collection('Quiz')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
          print(e.toString());
    });
  }

  Future<void> addQuestionDataQuiz(Map questionData, String quizId) async {
    await Firestore.instance.collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
          print(e);
    });
  }

  getQuizezDataQuiz() async {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  getQuizDataQuiz(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataFilm(Map quizData, String quizId) async {
    await Firestore.instance.collection('Film')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataFilm(Map questionData, String quizId) async {
    await Firestore.instance.collection("Film")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataFilm() async {
    return await Firestore.instance.collection("Film").snapshots();
  }

  getQuizDataFilm(String quizId) async {
    return await Firestore.instance
        .collection("Film")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataScience(Map quizData, String quizId) async {
    await Firestore.instance.collection('Science')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataScience(Map questionData, String quizId) async {
    await Firestore.instance.collection("Science")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataScience() async {
    return await Firestore.instance.collection("Science").snapshots();
  }

  getQuizDataScience(String quizId) async {
    return await Firestore.instance
        .collection("Science")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataTechnology(Map quizData, String quizId) async {
    await Firestore.instance.collection('Technology')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataTechnology(Map questionData, String quizId) async {
    await Firestore.instance.collection("Technology")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataTechnology() async {
    return await Firestore.instance.collection("Technology").snapshots();
  }

  getQuizDataTechnology(String quizId) async {
    return await Firestore.instance
        .collection("Technology")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataGeography(Map quizData, String quizId) async {
    await Firestore.instance.collection('Geography')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataGeography(Map questionData, String quizId) async {
    await Firestore.instance.collection("Geography")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataGeography() async {
    return await Firestore.instance.collection("Geography").snapshots();
  }

  getQuizDataGeography(String quizId) async {
    return await Firestore.instance
        .collection("Geography")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataSoftware(Map quizData, String quizId) async {
    await Firestore.instance.collection('Software')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataSoftware(Map questionData, String quizId) async {
    await Firestore.instance.collection("Software")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataSoftware() async {
    return await Firestore.instance.collection("Software").snapshots();
  }

  getQuizDataSoftware(String quizId) async {
    return await Firestore.instance
        .collection("Software")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataSports(Map quizData, String quizId) async {
    await Firestore.instance.collection('Sports')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataSports(Map questionData, String quizId) async {
    await Firestore.instance.collection("Sports")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataSports() async {
    return await Firestore.instance.collection("Sports").snapshots();
  }

  getQuizDataSports(String quizId) async {
    return await Firestore.instance
        .collection("Sports")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataMusic(Map quizData, String quizId) async {
    await Firestore.instance.collection('Music')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataMusic(Map questionData, String quizId) async {
    await Firestore.instance.collection("Music")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataMusic() async {
    return await Firestore.instance.collection("Music").snapshots();
  }

  getQuizDataMusic(String quizId) async {
    return await Firestore.instance
        .collection("Music")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataArt(Map quizData, String quizId) async {
    await Firestore.instance.collection('Art')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataArt(Map questionData, String quizId) async {
    await Firestore.instance.collection("Art")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataArt() async {
    return await Firestore.instance.collection("Art").snapshots();
  }

  getQuizDataArt(String quizId) async {
    return await Firestore.instance
        .collection("Art")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataHistory(Map quizData, String quizId) async {
    await Firestore.instance.collection('History')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataHistory(Map questionData, String quizId) async {
    await Firestore.instance.collection("History")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataHistory() async {
    return await Firestore.instance.collection("History").snapshots();
  }

  getQuizDataHistory(String quizId) async {
    return await Firestore.instance
        .collection("History")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  Future<void> addQuizDataAnimals(Map quizData, String quizId) async {
    await Firestore.instance.collection('Animals')
        .document(quizId)
        .setData(quizData)
        .catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionDataAnimals(Map questionData, String quizId) async {
    await Firestore.instance.collection("Animals")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e){
      print(e);
    });
  }

  getQuizezDataAnimals() async {
    return await Firestore.instance.collection("Animals").snapshots();
  }

  getQuizDataAnimals(String quizId) async {
    return await Firestore.instance
        .collection("Animals")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }
}