import 'package:flutter/material.dart';
import '../components/appBarCustom.dart';
import '../constants/colors.dart';
import '../constants/helpers.dart';
import '../constants/textStyle.dart';

class Rules extends StatefulWidget {
  final Size sizeScreen;

  const Rules({
    Key? key,
    required this.sizeScreen,
  }) : super(key: key);

  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: 'Regras do Jogo'),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: widget.sizeScreen.height * .8,
            width: widget.sizeScreen.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: background,
                  backgroundImage: AssetImage(kLogo),
                  radius: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    kTitle,
                    style: textWord,
                  ),
                ),
                Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        24,
                      ),
                      child: Text(
                        kRules,
                        textAlign: TextAlign.center,
                        style: textRules,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
