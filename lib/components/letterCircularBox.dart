import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/textStyle.dart';

class Letter extends StatefulWidget {
  final Size sizeScreen;
  late List<bool> isEnable;
  int index;
  String letter;

  Letter({
    Key? key,
    required this.sizeScreen,
    required this.isEnable,
    required this.index,
    required this.letter,
  }) : super(key: key);
  @override
  State<Letter> createState() => _LetterState();
}

class _LetterState extends State<Letter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeScreen.width * 0.2,
      height: widget.sizeScreen.height * 0.08,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.isEnable[widget.index] ? secondary : disable,
      ),
      child: Center(
        child: Text(
          widget.letter,
          style: textLetter,
        ),
      ),
    );
  }
}
