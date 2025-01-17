import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hangwoman/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String word = "";
  String current = "";
  String eliminated = "";
  Characters? options;
  int score = 0;
  var widgetOptions = <Widget>[];

  @override
  void initState() {
    super.initState();
    doTheMagic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(26, 0, 26, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "$score",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                "assets/gifs/Kfde.gif",
                height: 300,
                width: 300,
              ),
              Text(
                "❤ ❤ ❤ ❤ ❤",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                current,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Column(
                children: widgetOptions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getOptions() {
    var list = <Widget>[];

    return list;
  }

  void doTheMagic() async {
    word = await generateWord(4 + Random().nextInt(4));
    word = word.toUpperCase();
    current = calculateInitDisplay(word);
    options = generateOptions(word, current, eliminated);
    widgetOptions = generateWidgets(options!, handleOptionSelection);
    setState(() {});
  }

  void handleOptionSelection(String alphabet) {
    print(alphabet);
    if (word.contains(alphabet)) {
      print("Contains");
      current = reveal(word, current, alphabet);
    } else {
      Fluttertoast.showToast(msg: "Galat Jawab!");
      eliminated += alphabet;
    }
    if (current.replaceAll(" ", "") != word) {
      options = generateOptions(word, current, eliminated);
      widgetOptions = generateWidgets(options!, handleOptionSelection);
    } else {
      wordGuessed();
    }
    setState(() {});
  }

  void wordGuessed() {
    Fluttertoast.showToast(msg: "Yay! The word was: $word");
    score += word.length;
    setState(() {});
    doTheMagic();
  }
}
