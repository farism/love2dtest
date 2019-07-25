import 'dart:ui';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './ui/screen_deck.dart';
import './ui/screen_modes.dart';
import './ui/screen_play.dart';
import './ui/screen_settings.dart';
import './ui/screen_social.dart';
import './ui/tabs.dart';

class MenuRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(children: [
        DefaultTabController(
          length: 4,
          initialIndex: 2,
          child: Scaffold(
            bottomNavigationBar: CustomTabBar(
              tabs: ['Social', 'Deck', 'Play', 'Settings'],
            ),
            body: CustomTabBarView(
              children: [
                Social(),
                Deck(),
                Modes((Mode mode) {
                  Navigator.pushNamed(context, '/play');
                }),
                Settings(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class PlayRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Play(),
    ]);
  }
}

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  // setWindowFrame(Rect.fromLTWH(1440, 200, 768, 1024));

  // setWindowFrame(Rect.fromLTWH(300, 200, 320, 480));

  final app = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MenuRoute(),
      '/play': (context) => PlayRoute(),
    },
    // home: Material(
    //   type: MaterialType.transparency,
    //   child: Directionality(
    //     textDirection: TextDirection.ltr,
    //     child: Stack(children: [
    //       DefaultTabController(
    //         length: 4,
    //         child: Scaffold(
    //           bottomNavigationBar: CustomTabBar(
    //             tabs: ['Social', 'Deck', 'Play', 'Settings'],
    //           ),
    //           body: CustomTabBarView(
    //             children: [
    //               Social(),
    //               Deck(),
    //               Modes((Mode mode) => print(mode)),
    //               Settings(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Play()
    //     ]),
    //   ),
    // ),
  );

  runApp(app);
}
