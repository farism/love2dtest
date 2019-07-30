import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';
import '../state/ui.dart';

class DeckRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final uiState = Provider.of<UIState>(context);

    return Observer(builder: (_) {
      return Expanded(
        child: Column(
          children: [
            Row(children: [
              Button(
                label: 'My Decks',
                onPressed: () {
                  uiState.setDeckView(DeckView.deckList);
                },
                color: uiState.deckView == DeckView.deckList
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Index',
                onPressed: () {
                  uiState.setDeckView(DeckView.cardIndex);
                },
                color: uiState.deckView == DeckView.cardIndex
                    ? Colors.green
                    : Colors.black,
              )
            ]),
            Container(
              child: Expanded(
                // color: Colors.green,
                child: uiState.deckView == DeckView.deckList
                    ? DeckListView()
                    : CardIndexView(),
              ),
            )
          ],
        ),
      );
    });
  }
}

class DeckListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final uiState = Provider.of<UIState>(context);

    return Observer(builder: (_) {
      return Container(
        child: ListView(
          children: appState.decks.map((deck) {
            return Container(
              child: Text(deck.name),
              padding: EdgeInsets.all(20),
            );
          }).toList(),
        ),
      );
    });
  }
}

class DeckDetailView extends StatelessWidget {
  DeckDetailView({this.deck});

  final String deck;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 50,
      child: ListView(
        children: [
          const Text('Deck Item'),
        ],
      ),
    );
  }
}

class DeckCardItem extends StatelessWidget {
  DeckCardItem({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Deck Item'),
    );
  }
}

class CardIndexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final uiState = Provider.of<UIState>(context);

    final categories =
        groupBy<Card, String>(appState.cards, (card) => card.category);

    return Observer(builder: (_) {
      return Container(
        child: ListView(
            children: categories.entries.toList().map((entry) {
          return CardCategory(name: entry.key, cards: entry.value);
        }).toList()),
      );
    });
  }
}

class CardCategory extends StatelessWidget {
  CardCategory({this.name, this.cards});

  final String name;
  final List<Card> cards;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(name),
      Container(
        color: Colors.blue,
        padding: EdgeInsets.all(20),
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: cards.map((card) {
            return Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Text(card.name),
            );
          }).toList(),
        ),
      )
    ]);
  }
}
