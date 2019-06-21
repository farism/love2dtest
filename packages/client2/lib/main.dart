import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  final game = MyGame();
  runApp(game.widget);

  Flame.util.addGestureRecognizer(
      TapGestureRecognizer()..onTapDown = (TapDownDetails evt) {});
}

class MyGame extends BaseGame {
  final TextConfig fpsTextConfig = TextConfig(color: const Color(0xFFFFFFFF));

  @override
  bool debugMode() => true;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    fpsTextConfig.render(canvas, fps(120).toString(), Position(0, 10));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
