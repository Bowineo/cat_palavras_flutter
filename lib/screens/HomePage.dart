import 'package:flutter/material.dart';
import '../components/appBarCustom.dart';
import '../components/buttonWordsFound.dart';
import '../components/drawerCustom.dart';
import '../components/matrix.dart';
import '../constants/helpers.dart';

class HomePage extends StatefulWidget {
  List<String> dictionary = [];
  HomePage({
    Key? key,
    required this.dictionary,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<List<String>> generatedMatrix;
  late List<dynamic> validWords = [];
  int countGeneratedMatrix = 0;
  TextEditingController wordController = TextEditingController();
  List<bool> isEnable = List.generate(18, (index) => true);
  List<int> clickOrder = [];

  @override
  void initState() {
    generatedMatrix = generateRandomMatrix(6, 3);
    countGeneratedMatrix++;
    while (!matrixValidate(generatedMatrix)) {
      generatedMatrix = generateRandomMatrix(6, 3);
    }
    print("generated: $countGeneratedMatrix ");
    printMatrix(generatedMatrix);
    wordController.addListener(() {
      if (wordController.text.length >= 4) {
        validateWord();
      }
    });
    super.initState();
  }

  void addValidWord() {
    setState(() {
      validWords.add(wordController.text);
    });
  }

  void clearWordController() {
    setState(() {
      wordController.text = '';
      isEnable.fillRange(0, isEnable.length, true);
      clickOrder = [];
    });
  }

  void validateWord() {
    bool isValid = isWordValid(wordController.text, generatedMatrix);
    if (!validWords.contains(wordController.text) &&
        isValid &&
        widget.dictionary.contains(wordController.text.toLowerCase())) {
      addValidWord();
      showValidationPopup(context, wordController.text);
      clearWordController();
    }
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  void generatedValidMatrix() {
    setState(() {
      countGeneratedMatrix = 0;
      validWords = [];
      generatedMatrix = invalidRandomMatrix(6, 3);
    });
    while (!matrixValidate(generatedMatrix)) {
      setState(() {
        generatedMatrix = generateRandomMatrix(6, 3);
      });
      countGeneratedMatrix++;
    }
    print("generated: $countGeneratedMatrix ");
    printMatrix(generatedMatrix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: kTitle),
      drawer: DrawerCustom(
        textTitle: kTitle,
        textTwo: 'Reiniciar',
        textOne: 'Regras',
        textThree: 'Sair',
        fncOne: () {},
        fncTwo: generatedValidMatrix,
        fncThree: clearWordController,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Matrix(
                matrix: generatedMatrix,
                validWords: validWords,
                sizeScreen: MediaQuery.of(context).size,
                wordController: wordController,
                isEnable: isEnable,
                clearWordController: clearWordController,
                clickOrder: clickOrder,
              ),
              ButtonWordsFound(
                sizeScreen: MediaQuery.of(context).size,
                validWords: validWords,
              )
            ],
          ),
        ),
      ),
    );
  }
}
