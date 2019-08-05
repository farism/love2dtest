import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show Colors, FlutterLogo;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';

class DecksRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      return Expanded(
        child: Column(
          children: [
            Row(children: [
              Button(
                label: 'My Decks',
                onPressed: () {
                  appState.ui.setDeckView(DeckView.deckList);
                },
                color: appState.ui.deckView == DeckView.deckList
                    ? Colors.green
                    : Colors.black,
              ),
              Button(
                label: 'Card Index',
                onPressed: () {
                  appState.ui.setDeckView(DeckView.cardsIndex);
                },
                color: appState.ui.deckView == DeckView.cardsIndex
                    ? Colors.green
                    : Colors.black,
              )
            ]),
            Container(
              child: Expanded(
                child: appState.ui.deckView == DeckView.deckList
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

class NewDeckRoute extends StatelessWidget {
  final nameController = TextEditingController.fromValue(
    TextEditingValue(
        selection: TextSelection(
      baseOffset: 0,
      extentOffset: 10,
    )),
  );

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    nameController.text = appState.ui.newDeckForm.name;

    return Observer(builder: (_) {
      return Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: EditableText(
                focusNode: FocusNode(),
                controller: nameController,
                backgroundCursorColor: Colors.red,
                cursorColor: Colors.blue,
                autofocus: true,
                onChanged: (value) {
                  appState.ui.newDeckForm.setNewDeckName(value);
                },
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                Button(
                  label: 'Assassin',
                  onPressed: () {
                    appState.ui.newDeckForm.setNewDeckHero(HeroType.assassin);
                  },
                  color: appState.ui.newDeckForm.hero == HeroType.assassin
                      ? Colors.green
                      : Colors.black,
                ),
                Button(
                  label: 'Warrior',
                  onPressed: () {
                    appState.ui.newDeckForm.setNewDeckHero(HeroType.warrior);
                  },
                  color: appState.ui.newDeckForm.hero == HeroType.warrior
                      ? Colors.green
                      : Colors.black,
                ),
                Button(
                  label: 'Healer',
                  onPressed: () {
                    appState.ui.newDeckForm.setNewDeckHero(HeroType.healer);
                  },
                  color: appState.ui.newDeckForm.hero == HeroType.healer
                      ? Colors.green
                      : Colors.black,
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(20)),
            Button(
              label: 'Create',
              onPressed: () {
                appState.user.addDeck(
                  appState.ui.newDeckForm.name,
                  appState.ui.newDeckForm.hero,
                  appState.ui,
                );

                Navigator.of(context).pushReplacementNamed('/decks/detail');
              },
            )
          ],
        ),
      );
    });
  }
}

class DeckDetailItem extends StatelessWidget {
  DeckDetailItem({this.card});

  final DeckCard card;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return RawButton(
      builder: (isPressed) {
        return Row(
          children: [
            FlutterLogo(),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                color: isPressed
                    ? Colors.red
                    : (card.isPurchased
                        ? (card.isActive ? Colors.green : Colors.blue)
                        : Colors.grey),
                child: Text(card.name),
                padding: EdgeInsets.all(20),
              ),
            ),
            Button(
              label: 'Info',
              onPressed: () {
                appState.ui.setActiveCard(card.name);

                Navigator.of(context).pushNamed('/card');
              },
            )
          ],
        );
      },
      onPressed: () {
        if (card.isPurchased) {
          appState.user.toggleCard(appState.activeDeck.id, card.name);
        }
      },
    );
  }
}

class DeckDetailRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      // reactive updates don't work without this for some reason
      final _ = appState.user.decks;

      final deck = appState.activeDeck;

      if (deck == null) {
        return Container(
          child: Text('Deck not found'),
        );
      }

      final cards = appState.deckCards(deck);

      final generalCards = cards.where((card) => card.card.hero == null);

      final heroCards = cards.where((card) => card.card.hero == deck.hero);

      return Expanded(
        child: Column(
          children: [
            Row(children: [
              RawButton(
                builder: (isPressed) => Container(
                  color: isPressed ? Colors.red : Colors.grey,
                  child: Text('Delete'),
                ),
                onPressed: () => appState.user.removeDeck(deck.id),
              ),
            ]),
            Text(deck.category),
            Text('${deck.cards.length} / 20'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Text('General'),
                  ...generalCards
                      .map((card) => DeckDetailItem(card: card))
                      .toList(),
                  Text(deck.category),
                  ...heroCards
                      .map((card) => DeckDetailItem(card: card))
                      .toList(),
                ]),
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

    return Observer(builder: (_) {
      return Container(
        child: Column(children: [
          Button(
            label: 'Create Deck',
            onPressed: () {
              Navigator.of(context).pushNamed('/decks/new');
            },
          ),
          Expanded(
            child: ListView.separated(
              itemCount: appState.user.decks.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final deck = appState.user.decks[index];

                return RawButton(
                  builder: (isPressed) {
                    return Row(children: [
                      Center(
                        child: FlutterLogo(
                          size: 32,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: isPressed ? Colors.red : Colors.blue,
                          child: Text(deck.name),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ]);
                  },
                  onPressed: () {
                    appState.ui.setActiveDeck(deck.id);

                    Navigator.of(context).pushNamed('/decks/detail');
                  },
                );
              },
            ),
          ),
        ]),
      );
    });
  }
}

class CardIndexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final categories =
        groupBy<Card, String>(allCards, (card) => card.heroString);

    return Observer(
      builder: (_) => Container(
        child: ListView(
            children: categories.entries
                .map(
                  (cat) => CardIndexCategory(name: cat.key, cards: cat.value),
                )
                .toList()),
      ),
    );
  }
}

class CardIndexCategory extends StatelessWidget {
  CardIndexCategory({this.name, this.cards});

  final String name;
  final List<Card> cards;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(name),
      ),
      Container(
        color: Colors.blue,
        padding: EdgeInsets.all(20),
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: cards.map(
            (card) {
              // final purchased = appState.isPurchased(card.name);

              return RawButton(
                builder: (isPressed) => Container(
                  padding: EdgeInsets.all(20),
                  color: isPressed ? Colors.red : Colors.grey,
                  child: Column(
                    children: [
                      Text(card.name),
                    ],
                  ),
                ),
                onPressed: () {
                  appState.ui.setActiveCard(card.name);

                  Navigator.of(context).pushNamed('/card');
                },
              );
            },
          ).toList(),
        ),
      )
    ]);
  }
}
