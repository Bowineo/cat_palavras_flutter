import 'package:flutter/material.dart';
import '../components/appBarCustom.dart';
import '../constants/textStyle.dart';

class WordsFound extends StatefulWidget {
  final Size sizeScreen;
  final List<dynamic> validWords;

  const WordsFound({
    Key? key,
    required this.validWords,
    required this.sizeScreen,
  }) : super(key: key);

  @override
  _WordsFoundState createState() => _WordsFoundState();
}

class _WordsFoundState extends State<WordsFound>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          title: widget.validWords.length == 1
              ? 'Formada ${widget.validWords.length} palavra'
              : 'Formadas ${widget.validWords.length} palavras'),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: widget.sizeScreen.height,
            width: widget.sizeScreen.width,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.validWords.length,
              itemBuilder: (context, index) {
                final word = widget.validWords[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      word.toString(),
                      style: textDefault,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
