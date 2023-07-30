import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/helpers.dart';
import '../constants/textStyle.dart';
import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

List<String> _dictionary = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString(kJsonWord[0]);
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<String> words = jsonData['words'].cast<String>();
    _dictionary = words;

    Future.delayed(
        Duration(milliseconds: 1000),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(dictionary: _dictionary),
                  ))
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (Container(
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(kLogo),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kTitle,
                  style: textSplashscreen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
