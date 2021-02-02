import 'package:commonLab/screens/play_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смертельная битва'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PlayScreen('gamer1')));
              },
              color: Colors.blue,
              child: Text('Игрок 1'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => PlayScreen('gamer2')));
              },
              color: Colors.red,
              child: Text('Игрок 2'),
            )
          ],
        ),
      ),
    );
  }
}
