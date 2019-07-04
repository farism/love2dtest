import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import 'game/game.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  MyGame game = MyGame();

  runApp(
    MaterialApp(
      home: Stack(children: [
        game.widget,
      ]),
    ),
  );

  game.addGestures();
}
