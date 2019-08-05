import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart' as app;

class CardRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final appState = Provider.of<app.AppState>(context);

      final card = appState.activeCard;

      if (card == null) {
        return Container(
          child: Text('Card not found'),
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(card.name),
          Text(card.heroString),
          Text(card.description),
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
