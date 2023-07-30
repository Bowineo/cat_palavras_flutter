import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'constants/helpers.dart';
import 'screens/Splashscreen.dart';

void main() {
  runApp(const TortoGame());
}

class TortoGame extends StatelessWidget {
  const TortoGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kTitle,
      theme: ThemeData(
        primarySwatch: materialPrimary,
      ),
      home: SplashScreen(),
    );
  }
}
