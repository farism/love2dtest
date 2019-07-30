import 'dart:async';
import 'dart:ui';

import 'package:client2/ui/about.dart';
import 'package:client2/ui/contact.dart';
import 'package:client2/ui/language.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import './state/app.dart';
import './state/ui.dart';
import './ui/arena.dart';
import './ui/chest.dart';
import './ui/common.dart';
import './ui/deck.dart';
import './ui/hero.dart';
import './ui/home.dart';
import './ui/play.dart';
import './ui/settings.dart';
import './ui/social.dart';
import './ui/store.dart';

PageRoute splashRoute() {
  return PageRouteBuilder(
    barrierColor: Color.fromRGBO(255, 255, 255, 1),
    barrierDismissible: false,
    opaque: true,
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed('/');
      });

      return Container(
        child: Image.asset('assets/images/logo.png'),
      );
    },
  );
}

PageRoute homeRoute() {
  return PageRouteBuilder(
    barrierColor: Color(0xFFFF0000),
    pageBuilder: (context, animation, secondaryAnimation) {
      return HomeRoute();
    },
  );
}

PageRoute modalRoute({Widget Function(BuildContext) builder}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    opaque: false,
    barrierColor: Color.fromRGBO(0, 0, 0, 0.8),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container(
        child: Modal(
          child: builder(context),
        ),
      );
    },
    transitionsBuilder: (context, animation, second, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(animation),
        child: child,
      );
    },
  );
}

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "splash":
      return splashRoute();
    case "/":
      return homeRoute();
    case "/map":
      return modalRoute(builder: (context) => ArenaRoute());
    case "/hero":
      return modalRoute(builder: (context) => HeroRoute());
    case "/social":
      return modalRoute(builder: (context) => SocialRoute());
    case "/deck":
      return modalRoute(builder: (context) => DeckRoute());
    case "/chest":
      return modalRoute(builder: (context) => ChestRoute());
    case "/play":
      return modalRoute(builder: (context) => PlayRoute());
    case "/settings":
      return modalRoute(builder: (context) => SettingsRoute());
    case "/settings/about":
      return modalRoute(builder: (context) => AboutRoute());
    case "/settings/contact":
      return modalRoute(builder: (context) => ContactRoute());
    case "/settings/language":
      return modalRoute(builder: (context) => LanguageRoute());
    case "/settings/security":
      return modalRoute(builder: (context) => SettingsRoute());
    case "/store":
      return modalRoute(builder: (context) => StoreRoute());
  }

  return null;
}

class App extends StatelessWidget {
  final _appState = AppState();
  final _uiState = UIState();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppState>.value(value: _appState),
        Provider<UIState>.value(value: _uiState),
      ],
      child: WidgetsApp(
        onGenerateRoute: generateRoute,
        initialRoute: "/",
        color: Colors.black,
      ),
    );
  }
}

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  // laptop
  setWindowFrame(Rect.fromLTWH(400, 100, 411, 731));

  // external
  // setWindowFrame(Rect.fromLTWH(1500, 200, 411, 731));

  runApp(App());
}
