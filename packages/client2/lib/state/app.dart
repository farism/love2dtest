import 'package:mobx/mobx.dart';

part 'app.g.dart';

class AppState = _AppState with _$AppState;

enum HeroType {
  assassin,
  healer,
  warrior,
}

enum ArenaType {
  square,
  pentagon,
  hexagon,
}

class Card {
  Card({this.name, this.description = '', this.hero});

  final String name;
  final String description;
  final HeroType hero;

  String get category => hero != null ? heroString(hero) : 'General';
}

List<Card> allCards = [
  Card(name: 'Zeus'),
  Card(name: 'Hera'),
  Card(name: 'Poseidon', hero: HeroType.assassin),
  Card(name: 'Demeter', hero: HeroType.assassin),
  Card(name: 'Ares', hero: HeroType.assassin),
  Card(name: 'Athena', hero: HeroType.warrior),
  Card(name: 'Apollo', hero: HeroType.warrior),
  Card(name: 'Artemis', hero: HeroType.warrior),
  Card(name: 'Hephaestus', hero: HeroType.warrior),
  Card(name: 'Aphrodite', hero: HeroType.healer),
  Card(name: 'Hermes', hero: HeroType.healer),
  Card(name: 'Dionysus', hero: HeroType.healer),
  Card(name: 'Hades', hero: HeroType.healer),
];

class MyDeck {
  MyDeck({this.name, this.cards = const []});

  final String name;
  final List<Card> cards;
}

List<MyDeck> myDecks = [
  MyDeck(name: 'Deck 1', cards: allCards.skip(1).take(10).toList()),
  MyDeck(name: 'Deck 2', cards: allCards.skip(2).take(2).toList()),
  MyDeck(name: 'Deck 3', cards: allCards.skip(3).take(4).toList()),
  MyDeck(name: 'Deck 4', cards: allCards.skip(4).take(3).toList()),
  MyDeck(name: 'Deck 5', cards: allCards.skip(5).take(1).toList()),
  MyDeck(name: 'Deck 6', cards: allCards.skip(6).take(5).toList()),
  MyDeck(name: 'Deck 7', cards: allCards.skip(7).take(4).toList()),
  MyDeck(name: 'Deck 8', cards: allCards.skip(8).take(2).toList()),
  MyDeck(name: 'Deck 9', cards: allCards.skip(9).take(1).toList()),
  MyDeck(name: 'Deck 10', cards: allCards.skip(10).take(1).toList()),
];

String heroString(HeroType type) {
  if (type == HeroType.assassin) {
    return 'Assassin';
  } else if (type == HeroType.healer) {
    return 'Healer';
  } else if (type == HeroType.warrior) {
    return 'Warrior';
  }

  return '';
}

String mapString(ArenaType type) {
  if (type == ArenaType.square) {
    return 'Square';
  } else if (type == ArenaType.pentagon) {
    return 'Pentagon';
  } else if (type == ArenaType.hexagon) {
    return 'Hexagon';
  }

  return '';
}

abstract class _AppState with Store {
  @observable
  bool _music = true;
  bool get music => _music;

  @observable
  bool _sound = true;
  bool get sound => _sound;

  @observable
  ArenaType _map = ArenaType.square;
  ArenaType get map => _map;

  @observable
  HeroType _hero = HeroType.assassin;
  HeroType get hero => _hero;

  @observable
  int _xp = 0;
  int get xp => _xp;

  @observable
  int _checkpoint = 0;
  int get checkpoint => _checkpoint;

  @observable
  int _coins = 0;
  int get coins => _coins;

  @observable
  int _gems = 0;
  int get gems => _gems;

  @observable
  List<Card> _cards = List.from(allCards);
  List<Card> get cards => _cards;

  @observable
  List<MyDeck> _decks = List.from(myDecks);
  List<MyDeck> get decks => _decks;

  @action
  void toggleMusic() {
    _music = !_music;
  }

  @action
  void toggleSound() {
    _sound = !_sound;
  }

  @action
  void setMap(ArenaType type) {
    _map = type;
  }

  @action
  void setHero(HeroType type) {
    _hero = type;
  }

  @action
  void setCoins(int val) {
    if (val < 0) {
      throw StateError('Cannot go below zero coins');
    }

    _coins = val;
  }

  @action
  void addCoins(int val) {
    _coins += val;
  }

  @action
  void removeCoins(int val) {
    if (val > coins) {
      throw StateError('Cannot go below zero coins');
    }

    _coins -= val;
  }

  @action
  void setGems(int val) {
    if (val < 0) {
      throw StateError('Cannot go below zero gems');
    }

    _gems = val;
  }

  @action
  void addGems(int val) {
    _gems += val;
  }

  @action
  void removeGems(int val) {
    if (val > gems) {
      throw StateError('Cannot go below zero gems');
    }

    _gems -= val;
  }
}
