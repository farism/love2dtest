import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Mode { VersusAI, VersusPlayer, Timed }

class Modes extends StatelessWidget {
  final Function(Mode) onSelectMode;

  Modes(this.onSelectMode);

  Widget build(BuildContext buildContext) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
            child: Text("vs ai"),
            onPressed: () => onSelectMode(Mode.VersusAI),
          ),
          RaisedButton(
            child: Text("vs player"),
            onPressed: () => onSelectMode(Mode.VersusPlayer),
          ),
          RaisedButton(
            child: Text("timed"),
            onPressed: () => onSelectMode(Mode.Timed),
          ),
        ],
      ),
    );
  }
}
