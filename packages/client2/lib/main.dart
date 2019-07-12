import 'dart:ui';

import 'package:client2/ui/screens/deck.dart';
import 'package:client2/ui/screens/modes.dart';
import 'package:client2/ui/screens/settings.dart';
import 'package:client2/ui/screens/social.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart' show setWindowFrame;

import './game/game.dart';
import './ui/components/tabs.dart';
import './ui/widgets.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  setWindowFrame(Rect.fromLTWH(1440, 200, 768, 1024));

  // setWindowFrame(Rect.fromLTWH(1440, 200, 320, 480));

  final game = Game();

  final app = MaterialApp(
    home: Material(
      type: MaterialType.transparency,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(children: [
          DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: CustomTabBar(
                tabs: ['Social', 'Deck', 'Modes', 'Settings'],
              ),
              body: CustomTabBarView(
                children: [
                  Social(),
                  Deck(),
                  Modes(),
                  Settings(),
                ],
              ),
            ),
          ),
          Container(
            child: RenderWidget(game),
            color: Color(0xFF222222),
            constraints: BoxConstraints.expand(),
          ),
        ]),
      ),
    ),
  );

  runApp(app);
}
