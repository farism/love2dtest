import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

import './common.dart';
import '../state/app.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      final settings = appState.settings;

      return Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          const Text("Settings"),
          Button(
            label: 'Sound: ${appState.settings.sound ? 'On' : 'Off'}',
            onPressed: () {
              appState.settings.toggleSound();
            },
          ),
          Button(
            label: 'Music: ${settings.music ? 'On' : 'Off'}',
            onPressed: () {
              appState.settings.toggleMusic();
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
              // launch('mailto:farismmk@gmail.com');
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
