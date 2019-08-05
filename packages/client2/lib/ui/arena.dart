import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';

class ArenaRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final close = () => Navigator.of(context).pop();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Map"),
        Button(
          label: 'Square',
          onPressed: () {
            appState.user.setArena(ArenaType.square);
            close();
          },
        ),
        Button(
          label: 'Pentagon',
          onPressed: () {
            appState.user.setArena(ArenaType.pentagon);
            close();
          },
        ),
        Button(
          label: 'Hexagon',
          onPressed: () {
            appState.user.setArena(ArenaType.hexagon);
            close();
          },
        ),
      ],
    );
  }
}
