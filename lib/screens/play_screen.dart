import 'dart:convert';

import 'package:commonLab/models/question.dart';
import 'package:commonLab/screens/end_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlayScreen extends StatefulWidget {
  final String gamer;
  PlayScreen(this.gamer);
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final List<Question> questions = [];
  var gamerCount = 0;
  v(q) {
    if (q.answer == 'v1') {
      return ('v1');
    } else if (q.answer == 'v2') {
      return ('v2');
    } else if (q.answer == 'v3') {
      return ('v3');
    } else if (q.answer == 'v4') {
      return ('v4');
    }
  }

  Future<void> fetchData() async {
    const url = 'https://quiz-125f6-default-rtdb.firebaseio.com/questions.json';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((id, data) {
        questions.add(Question(
          id: id,
          text: data['text'],
          v1: data['v1'],
          v2: data['v2'],
          v3: data['v3'],
          v4: data['v4'],
          answer: data['answer'],
        ));
      });
    } catch (error) {
      throw (error);
    }
  }

  var counter = 0;
  var _isInit = true;
  var isLoading = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchData().then((_) {
        setState(() {
          isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Смертельная битва')),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: isLoading
              ? CircularProgressIndicator()
              : Container(
                  child: (counter < questions.length)
                      ? Column(
                          children: [
                            Text(questions[counter].text),
                            Spacer(),
                            FlatButton(
                              onPressed: (() {
                                if (questions[counter].answer == 'v1') {
                                  gamerCount++;
                                  print(gamerCount);
                                }
                                setState(() {
                                  counter++;
                                });
                              }),
                              color: Colors.grey,
                              child: Text(questions[counter].v1),
                            ),
                            FlatButton(
                              onPressed: (() {
                                if (questions[counter].answer == 'v2') {
                                  gamerCount++;
                                  print(gamerCount);
                                }
                                setState(() {
                                  counter++;
                                });
                              }),
                              color: Colors.grey,
                              child: Text(questions[counter].v2),
                            ),
                            FlatButton(
                              onPressed: (() {
                                if (questions[counter].answer == 'v3') {
                                  gamerCount++;
                                  print(gamerCount);
                                }
                                setState(() {
                                  counter++;
                                });
                              }),
                              color: Colors.grey,
                              child: Text(questions[counter].v3),
                            ),
                            FlatButton(
                              onPressed: (() {
                                if (questions[counter].answer == 'v4') {
                                  gamerCount++;
                                  print(gamerCount);
                                }
                                setState(() {
                                  counter++;
                                });
                              }),
                              color: Colors.grey,
                              child: Text(questions[counter].v4),
                            ),
                          ],
                        )
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  EndScreen(gamerCount, widget.gamer))),
                ),
        ),
      ),
    );
  }
}
