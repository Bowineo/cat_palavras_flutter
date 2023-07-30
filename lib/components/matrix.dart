import 'package:cat_palavras_game/components/letterCircularBox.dart';
import 'package:flutter/material.dart';
import 'textFieldCustom.dart';

class Matrix extends StatefulWidget {
  final Size sizeScreen;
  late List<List<String>> matrix;
  late List<dynamic> validWords;
  late TextEditingController wordController;
  late List<bool> isEnable;
  final Function clearWordController;
  late List<int> clickOrder;

  Matrix({
    Key? key,
    required this.matrix,
    required this.sizeScreen,
    required this.validWords,
    required this.wordController,
    required this.isEnable,
    required this.clearWordController,
    required this.clickOrder,
  }) : super(key: key);

  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  void removeLastLetter() {
    setState(() {
      widget.wordController.text = widget.wordController.text
          .substring(0, widget.wordController.text.length - 1);
      widget.isEnable[widget.clickOrder.last] = true;
      widget.clickOrder.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldCustom(
                onDismissible: widget.clearWordController,
                sizeScreen: MediaQuery.of(context).size,
                wordController: widget.wordController,
                iconButton: removeLastLetter,
                iconData: Icons.backspace),
            SizedBox(
              width: widget.sizeScreen.width * 0.6,
              height: widget.sizeScreen.height * .65,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = (index / 3).floor();
                  int col = index % 3;
                  String letter = widget.matrix[row][col];
                  return GestureDetector(
                      onTap: widget.isEnable[index]
                          ? () {
                              setState(() {
                                widget.isEnable[index] = false;
                                if (widget.wordController.text.length < 18) {
                                  widget.wordController.text =
                                      widget.wordController.text + letter;
                                  widget.clickOrder.add(index);
                                }
                              });
                            }
                          : null,
                      child: Letter(
                        sizeScreen: widget.sizeScreen,
                        isEnable: widget.isEnable,
                        index: index,
                        letter: letter,
                      ));
                },
                itemCount: widget.matrix.length * widget.matrix[0].length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
