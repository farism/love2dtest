import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';

class CardRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final appState = Provider.of<AppState>(context);

      final gold = appState.user.gold;

      final card = appState.cards
          .firstWhere((card) => card.name == appState.ui.activeCardId);

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
          card.purchased
              ? Container()
              : RawButton(
                  builder: (isPressed) {
                    return Container(
                      color: card.gold > gold
                          ? Colors.grey
                          : (isPressed ? Colors.red : Colors.blue),
                      child: Text('Purchase: ${card.gold}'),
                    );
                  },
                  onPressed: () {
                    appState.user.purchaseCard(card.name);
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
