import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeckCard extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
        child: Text("card"),
      ),
    );
  }
}

class Deck extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return Column(
      children: [
        Text("deck"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("utility"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("warrior"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("assassin"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("healer"),
              onPressed: () {},
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  DeckCard(),
                  DeckCard(),
                  DeckCard(),
                  DeckCard(),
                  DeckCard(),
                  DeckCard(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
