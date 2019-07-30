import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Settings"),
          Button(
            label: 'Sound: ${appState.sound ? 'On' : 'Off'}',
            onPressed: () {
              appState.toggleSound();
            },
          ),
          Button(
            label: 'Music: ${appState.music ? 'On' : 'Off'}',
            onPressed: () {
              appState.toggleMusic();
            },
          ),
          Button(
            label: 'About',
            onPressed: () {
              Navigator.of(context).pushNamed("/settings/about");
            },
          ),
          Button(
            label: 'Contact',
            onPressed: () {
              Navigator.of(context).pushNamed("/settings/contact");
            },
          ),
          Button(
            label: 'Language',
            onPressed: () {
              Navigator.of(context).pushNamed("/settings/language");
            },
          ),
          Button(
            label: 'Security',
            onPressed: () {
              Navigator.of(context).pushNamed("/settings/security");
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
