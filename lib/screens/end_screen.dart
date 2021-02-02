import 'package:commonLab/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:commonLab/models/gamers.dart';
import 'package:http/http.dart' as http;

class EndScreen extends StatefulWidget {
  final int gamerCount;
  final String gamer;
  EndScreen(this.gamerCount, this.gamer);

  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  final url = 'https://quiz-125f6-default-rtdb.firebaseio.com/gamers.json';
  Map<String, dynamic> gamers = {'gamer1': '', 'gamer2': ''};
  var gamer1;
  var gamer2;

  Future<void> gamersCount() async {
    if (widget.gamer == 'gamer1') {
      final response = await http.patch(url,
          body: json.encode({'gamer1': widget.gamerCount + 1}));
    } else {
      final response = await http.patch(url,
          body: json.encode({'gamer2': widget.gamerCount + 1}));
    }
  }

  Future<void> gamersCount2() async {
    if (widget.gamer == 'gamer1') {
      final response = await http.patch(url, body: json.encode({'gamer1': 0}));
      final response1 = await http.patch(url, body: json.encode({'gamer2': 0}));
    }
  }

  Future<void> fetchData() async {
    const url = 'https://quiz-125f6-default-rtdb.firebaseio.com/gamers.json';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      var g = extractedData['gamer1'];
      var g2 = extractedData['gamer2'];
      gamers = {'gamer1': g, 'gamer2': g2};
      print('extr data $g');
    } catch (error) {
      throw (error);
    }
  }

  var isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    gamersCount().then((_) {
      setState(() {
        isLoading = false;
      });
    }).then((_) {
      print('gamers $gamers');
    });
    fetchData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Исход'),
      ),
      body: Column(children: [
        Container(
          child: (isLoading)
              ? CircularProgressIndicator()
              : Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 200),
                    child: (gamers['gamer1'] == null ||
                            gamers['gamer2'] == null ||
                            gamers['gamer1'] == 0 ||
                            gamers['gamer2'] == 0)
                        ? CircularProgressIndicator()
                        : Column(children: [
                            Container(
                              child: (widget.gamer == 'gamer1')
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text(
                                              'Вы заработали ${(gamers['gamer1']).toString()} очков'),
                                          Text(
                                              'Ваш соперник закаботал ${(gamers['gamer2']).toString()} очков')
                                        ])
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text(
                                              'Вы заработали ${(gamers['gamer2']).toString()} очков'),
                                          Text(
                                              'Ваш соперник заработал ${(gamers['gamer1']).toString()} очков')
                                        ]),
                            ),
                            FlatButton(
                              onPressed: () {
                                gamersCount2();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => StartScreen()));
                              },
                              child: Text('Обнулиться'),
                            )
                          ]),
                  ),
                ),
        ),
      ]),
    );
  }
}
