import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            label: 'Map: ${mapString(appState.map)}',
            onPressed: () {
              Navigator.of(context).pushNamed("/map");
            },
          ),
          Button(
            label: 'Hero: ${heroString(appState.hero)}',
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
              Navigator.of(context).pushNamed("/deck");
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
