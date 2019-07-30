import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class SocialRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final uiState = Provider.of<UIState>(context);

    Widget view;

    if (uiState.socialView == SocialView.challenge) {
      view = ChallengeView();
    } else if (uiState.socialView == SocialView.trade) {
      view = TradeView();
    } else if (uiState.socialView == SocialView.team) {
      view = TeamView();
    }

    return Observer(builder: (_) {
      return Expanded(
        child: Column(
          children: [
            Row(children: [
              Button(
                label: 'Challenge',
                onPressed: () {
                  uiState.setSocialView(SocialView.challenge);
                },
                color: uiState.socialView == SocialView.challenge
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Trade',
                onPressed: () {
                  uiState.setSocialView(SocialView.trade);
                },
                color: uiState.socialView == SocialView.trade
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Team',
                onPressed: () {
                  uiState.setSocialView(SocialView.team);
                },
                color: uiState.socialView == SocialView.team
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

class ChallengeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final uiState = Provider.of<UIState>(context);

    return Observer(builder: (_) {
      return Container(
        child: ListView(children: []),
      );
    });
  }
}

class TradeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final uiState = Provider.of<UIState>(context);

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
    final uiState = Provider.of<UIState>(context);

    return Observer(builder: (_) {
      return Container(
        child: ListView(children: []),
      );
    });
  }
}
