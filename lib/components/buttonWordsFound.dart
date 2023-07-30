import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/textStyle.dart';
import '../screens/WordsFound.dart';

class ButtonWordsFound extends StatefulWidget {
  final Size sizeScreen;
  late List<dynamic> validWords;

  ButtonWordsFound({
    Key? key,
    required this.sizeScreen,
    required this.validWords,
  }) : super(key: key);

  @override
  State<ButtonWordsFound> createState() => _ButtonWordsFoundState();
}

class _ButtonWordsFoundState extends State<ButtonWordsFound> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WordsFound(
                                validWords: widget.validWords.reversed.toList(),
                                sizeScreen: widget.sizeScreen,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  primary: secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  textStyle: textAux,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: SizedBox(
                  width: widget.sizeScreen.width * .6,
                  height: widget.sizeScreen.height * .05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.validWords.length == 1
                            ? 'Formada ${widget.validWords.length} palavra'
                            : 'Formadas ${widget.validWords.length} palavras',
                        style: textAux,
                      )
                    ],
                  ),
                ),
              ),
            ),
            visible: widget.validWords.isNotEmpty,
          )
        ],
      ),
    );
  }
}
