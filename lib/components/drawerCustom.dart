import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/helpers.dart';
import '../constants/textStyle.dart';
import '../screens/Rules.dart';

class DrawerCustom extends StatelessWidget {
  Function fncOne;
  Function fncTwo;
  Function fncThree;
  String textTitle;
  String textOne;
  String textTwo;
  String textThree;

  DrawerCustom({
    Key? key,
    required this.fncOne,
    required this.fncTwo,
    required this.fncThree,
    required this.textOne,
    required this.textTwo,
    required this.textThree,
    required this.textTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: background,
                  backgroundImage: AssetImage(kLogo),
                  radius: 40,
                ),
                Text(
                  textTitle,
                  style: textAux,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              textOne,
              style: textDefault,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Rules(
                      sizeScreen: MediaQuery.of(context).size,
                    ),
                  ));
            },
          ),
          ListTile(
            title: Text(
              textTwo,
              style: textDefault,
            ),
            onTap: () {
              fncTwo();
              fncThree();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              textThree,
              style: textDefault,
            ),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
