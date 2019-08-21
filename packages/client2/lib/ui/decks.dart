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
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    nameController.text = appState.ui.newDeckForm.name;

    return Observer(builder: (_) {
      return Container(
        child: Column(
          children: [
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
            Padding(padding: EdgeInsets.all(20)),
            Button(
              label: 'Create',
              onPressed: () {
                final id = uuid();

                appState.user.addDeck(Deck(
                  id: id,
                  hero: appState.ui.newDeckForm.hero,
                  name: nameController.text,
                ));

                appState.ui.setActiveDeck(id);

                Navigator.of(context).pushReplacementNamed('/decks/detail');
              },
            )
          ],
        ),
      );
    });
  }
}

class RenameDeckRoute extends StatelessWidget {
  final nameController = TextEditingController.fromValue(
    TextEditingValue(
      selection: TextSelection(
        baseOffset: 0,
        extentOffset: 10,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    nameController.text = appState.activeDeck.name;

    return Container(
      child: Column(
        children: [
          Text('Rename deck'),
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
          Button(
            label: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Button(
            label: 'Update',
            onPressed: () {
              appState.user.renameDeck(
                appState.activeDeck.id,
                nameController.text,
              );

              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

class DeckDetailItem extends StatelessWidget {
  DeckDetailItem({this.active, this.card});

  final active;

  final card;

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
                    : (card.purchased
                        ? (card.active ? Colors.green : Colors.blue)
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
        if (card.purchased) {
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
      final deck = appState.activeDeck;

      if (deck == null) {
        return Container(
          child: Text('Deck not found'),
        );
      }

      final cards = appState.activeDeckCards;

      final generalCards = cards.where((card) => card.hero == null);

      final heroCards = cards.where((card) => card.hero == deck.hero);

      return Expanded(
        child: Column(
          children: [
            Row(children: [
              Button(
                label: 'Delete',
                onPressed: () {
                  appState.user.removeDeck(deck.id);
                },
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(deck.name),
              Button(
                label: 'Edit',
                onPressed: () {
                  Navigator.of(context).pushNamed('/decks/rename');
                },
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

    final cards = appState.cards;

    final categories = cards.map((card) => card.heroString).toSet();

    return Observer(builder: (_) {
      return Container(
        child: ListView(
          children: categories
              .map((category) => CardIndexCategory(category: category))
              .toList(),
        ),
      );
    });
  }
}

class CardIndexCategory extends StatelessWidget {
  CardIndexCategory({this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Observer(builder: (_) {
      final cards = appState.cards.where((card) => card.heroString == category);

      return Column(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(category),
        ),
        Container(
          color: Colors.blue,
          padding: EdgeInsets.all(20),
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: cards.map(
              (card) {
                return RawButton(
                  builder: (isPressed) => Container(
                    padding: EdgeInsets.all(20),
                    color: isPressed
                        ? Colors.red
                        : card.purchased ? Colors.green : Colors.grey,
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
    });
  }
}
