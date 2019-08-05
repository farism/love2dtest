import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show Colors, Divider, FlutterLogo;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
//

class SocialRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      Widget view;

      if (appState.ui.socialView == SocialView.achievements) {
        view = AchievementsView();
      } else if (appState.ui.socialView == SocialView.trade) {
        view = TradeView();
      } else if (appState.ui.socialView == SocialView.team) {
        view = TeamView();
      }

      return Expanded(
        child: Column(
          children: [
            Row(children: [
              Button(
                label: 'Achievements',
                onPressed: () {
                  appState.ui.setSocialView(SocialView.achievements);
                },
                color: appState.ui.socialView == SocialView.achievements
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Trade',
                onPressed: () {
                  appState.ui.setSocialView(SocialView.trade);
                },
                color: appState.ui.socialView == SocialView.trade
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Team',
                onPressed: () {
                  appState.ui.setSocialView(SocialView.team);
                },
                color: appState.ui.socialView == SocialView.team
                    ? Colors.green
                    : Colors.black,
              )
            ]),
            Container(
              child: Expanded(
                child: view,
              ),
            )
          ],
        ),
      );
    });
  }
}

class AchievementsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Container(
        child: Column(children: [
          Expanded(
            child: ListView.separated(
              itemCount: appState.user.achievements.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white,
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                final achievements = appState.user.achievements[index];

                return Row(children: [
                  Center(
                    child: FlutterLogo(
                      size: 32,
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Text(achievements.name),
                    padding: EdgeInsets.all(20),
                  ),
                  Expanded(
                    child: Container(
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child:
                        Text('${achievements.current} / ${achievements.total}'),
                    padding: EdgeInsets.all(20),
                  ),
                ]);
              },
            ),
          ),
        ]),
      );
    });
  }
}

class TradeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Container(
        child: ListView(children: []),
      );
    });
  }
}

class TeamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Container(
        child: ListView(children: []),
      );
    });
  }
}
