import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class HeroRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final close = () => Navigator.of(context).pop();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Hero"),
        Button(
          label: 'Assassin',
          onPressed: () {
            appState.setHero(HeroType.assassin);
            close();
          },
        ),
        Button(
          label: 'Healer',
          onPressed: () {
            appState.setHero(HeroType.healer);
            close();
          },
        ),
        Button(
          label: 'Warrior',
          onPressed: () {
            appState.setHero(HeroType.warrior);
            close();
          },
        ),
      ],
    );
  }
}
