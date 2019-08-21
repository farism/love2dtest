import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart' as App;

class ChestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<App.AppState>(context);

    return Observer(builder: (_) {
      final duration = appState.chest.duration;

      final minutes = duration.inMinutes;

      final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Chest"),
          duration.inSeconds > 0
              ? Text('$minutes:$seconds')
              : Button(
                  label: 'Open',
                  onPressed: () {
                    appState.chest
                        .setTimestamp(DateTime.now().millisecondsSinceEpoch);

                    appState.user.addGold(100);
                  },
                ),
          Button(
            label: 'Back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
