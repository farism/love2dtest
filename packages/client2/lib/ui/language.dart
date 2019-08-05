import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './common.dart';

class Locale extends StatelessWidget {
  Locale(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(text),
      ),
    );
  }
}

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Language"),
        Expanded(
          child: Stack(
            children: [
              // height: 400,
              ListWheelScrollView(
                onSelectedItemChanged: (i) {
                  print(i);
                },
                physics: FixedExtentScrollPhysics(),
                children: [
                  Locale('English'),
                  Locale('Spanish'),
                  Locale('French'),
                  Locale('Italian'),
                  Locale('German'),
                  Locale('Russian'),
                  Locale('Chinese'),
                  Locale('Japanese'),
                ],
                itemExtent: 50,
              ),
              IgnorePointer(
                child: Center(
                  child: Container(
                    height: 50,
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              )
            ],
          ),
        ),
        Button(
          label: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}
