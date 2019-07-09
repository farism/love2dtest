import 'dart:ui';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
// import 'package:window_size/window_size.dart' show setWindowFrame;

import './game/bashem.dart';

class CustomTabBoxPainter extends BoxPainter {
  paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size;
    canvas.drawRect(rect, Paint()..color = Color(0xFFFF0000));
  }
}

class TabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return CustomTabBoxPainter();
  }
}

class CustomTabBarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Container(child: Text('social')),
        Container(child: Text('deck')),
        Container(
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              print(details);
            },
            onPanUpdate: (DragUpdateDetails details) {
              print(details);
            },
            onPanEnd: (DragEndDetails details) {},
            child: Container(
              child: game.widget,
              color: Color(0xFF222222),
              constraints: BoxConstraints.expand(),
            ),
          ),
        ),
        Container(child: Text('settings')),
      ],
    );
  }
}

class CustomTabBar extends StatelessWidget {
  Widget build(BuildContext context) {
    print(DefaultTabController.of(context).index);

    return TabBar(
      indicator: TabIndicator(),
      tabs: [
        Tab(
          child: Container(
            child: Text(
              "social",
              style: TextStyle(color: Color(0xFF000000)),
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Text(
              "deck",
              style: TextStyle(color: Color(0xFF000000)),
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Text(
              "play",
              style: TextStyle(color: Color(0xFF000000)),
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Text(
              "settings",
              style: TextStyle(color: Color(0xFF000000)),
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  // setWindowFrame(Rect.fromLTWH(1440, 200, 768, 1024));

  // setWindowFrame(Rect.fromLTWH(1440, 200, 320, 480));

  final game = BashEm();

  runApp(MaterialApp(
    home: DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        body: CustomTabBarView(),
        bottomNavigationBar: CustomTabBar(),
      ),
    ),
  ));
}
