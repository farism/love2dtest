import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBoxPainter extends BoxPainter {
  @override
  paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size;

    canvas.drawRect(rect, Paint()..color = Color(0xFFFF0000));
  }
}

class TabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return TabBoxPainter();
  }
}

class CustomTabBarView extends StatelessWidget {
  final List<Widget> children;

  CustomTabBarView({this.children});

  Widget build(BuildContext context) {
    return TabBarView(
      children: children,
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;

  CustomTabBar({this.tabs});

  Widget build(BuildContext context) {
    return TabBar(
      indicator: TabIndicator(),
      tabs: tabs.map((tab) => Container(child: Text(tab))).toList(),
    );
  }
}
