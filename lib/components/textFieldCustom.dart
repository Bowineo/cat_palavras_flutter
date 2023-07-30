import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/textStyle.dart';

class TextFieldCustom extends StatefulWidget {
  Function onDismissible;
  Size sizeScreen;
  TextEditingController wordController;
  Function iconButton;
  IconData iconData;

  TextFieldCustom({
    Key? key,
    required this.onDismissible,
    required this.sizeScreen,
    required this.wordController,
    required this.iconButton,
    required this.iconData,
  }) : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  DismissDirection diretion = DismissDirection.endToStart;
  GlobalKey textField = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.wordController.text.isNotEmpty,
      child: Dismissible(
        onDismissed: (diretion) {
          widget.onDismissible();
        },
        key: textField,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.sizeScreen.width * .8,
                height: widget.sizeScreen.height * .08,
                child: TextField(
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.center,
                  maxLength: 18,
                  textAlign: TextAlign.center,
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: widget.wordController,
                  style: textWord,
                ),
              ),
            ),
            IconButton(
              iconSize: 24,
              icon: Icon(
                Icons.backspace,
                color: secondary,
              ),
              onPressed: () {
                widget.iconButton();
              },
            )
          ],
        ),
      ),
    );
  }
}
