import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart' as App;

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<App.AppState>(context);

    return Observer(builder: (_) {
      return Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          Button(
            label: 'Arena: ${App.Arena.string(appState.user.arena)}',
            onPressed: () {
              Navigator.of(context).pushNamed("/arena");
            },
          ),
          Button(
            label: 'Hero: ${App.Hero.string(appState.user.hero)}',
            onPressed: () {
              Navigator.of(context).pushNamed("/hero");
            },
          ),
          Button(
            label: 'Social',
            onPressed: () {
              Navigator.of(context).pushNamed("/social");
            },
          ),
          Button(
            label: 'Deck',
            onPressed: () {
              Navigator.of(context).pushNamed("/decks");
            },
          ),
          Button(
            label: 'Chest',
            onPressed: () {
              Navigator.of(context).pushNamed("/chest");
            },
          ),
          Button(
            label: 'Play',
            onPressed: () {
              Navigator.of(context).pushNamed("/play");
            },
          ),
          Button(
            label: 'Settings',
            onPressed: () {
              Navigator.of(context).pushNamed("/settings");
            },
          ),
          Button(
            label: 'Store',
            onPressed: () {
              Navigator.of(context).pushNamed("/store");
            },
          ),
        ],
      );
    });
  }
}
