import 'package:flutter/foundation.dart';

class Question {
  final String id;
  final String text;
  final String v1;
  final String v2;
  final String v3;
  final String v4;
  final String answer;

  Question(
      {@required this.id,
      @required this.text,
      @required this.v1,
      @required this.v2,
      @required this.v3,
      @required this.v4,
      @required this.answer});
}
