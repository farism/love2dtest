import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final appState = Provider.of<AppState>(context);

      final xp = appState.user.xp;

      final checkpoint = appState.user.checkpoint;

      final gold = appState.user.gold;

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('XP: ${xp.toString()}'),
              Text('Level: ${checkpoint.toString()}'),
              RawButton(
                builder: (isPressed) {
                  return Text('Gold: ${gold.toString()}');
                },
                onPressed: () {
                  appState.user.addGold(10);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
