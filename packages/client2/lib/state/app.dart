import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app.g.dart';

const String defaultDescription =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut cursus dui eget turpis mollis fermentum. Donec porta felis imperdiet egestas porttitor.';

enum DeckView {
  deckList,
  cardsIndex,
}

enum SocialView {
  achievements,
  trade,
  team,
}

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

class Achievement {
  Achievement({this.name = '', this.description = '', this.total = 0});

  final String name;

  final String description;

  final int total;

  final int current = 0;

  double get progress => current / total;
}

class Card {
  Card({
    this.name,
    this.hero,
    this.description = defaultDescription,
    this.gold = 0,
  });

  final String name;

  final HeroType hero;

  int gold;

  String description;

  String get heroString => Hero.string(hero);
}

class Deck {
  Deck({this.id, this.name, this.hero, this.cards}) {
    cards ??= [];
  }

  final String id;

  final String name;

  final HeroType hero;

  List<String> cards;

  String get category => hero != null ? Hero.string(hero) : 'General';
}

class DeckCard {
  DeckCard({this.card, this.isPurchased = false, this.isActive = false});

  final Card card;

  final bool isPurchased;

  final bool isActive;

  String get name => card.name;
}

class Arena {
  static const String square = 'Square';

  static const String pentagon = 'Pentagon';

  static const String hexagon = 'Hexagon';

  static ArenaType random() {
    final rand = Random().nextInt(3);

    switch (rand) {
      case 0:
        return ArenaType.square;
      case 1:
        return ArenaType.pentagon;
      default:
        return ArenaType.hexagon;
    }
  }

  static ArenaType type(String type) {
    switch (type) {
      case Arena.square:
        return ArenaType.square;
      case Arena.pentagon:
        return ArenaType.pentagon;
      case Arena.hexagon:
        return ArenaType.hexagon;
    }

    return null;
  }

  static String string(ArenaType type) {
    switch (type) {
      case ArenaType.square:
        return Arena.square;
      case ArenaType.pentagon:
        return Arena.pentagon;
      case ArenaType.hexagon:
        return Arena.hexagon;
    }

    return 'Unknown ArenaType';
  }
}

class Hero {
  static const String assassin = 'Assassin';

  static const String healer = 'Healer';

  static const String warrior = 'Warrior';

  static HeroType random() {
    final rand = Random().nextInt(3);

    switch (rand) {
      case 0:
        return HeroType.assassin;
      case 1:
        return HeroType.healer;
      default:
        return HeroType.warrior;
    }
  }

  static HeroType type(String type) {
    switch (type) {
      case Hero.assassin:
        return HeroType.assassin;
      case Hero.healer:
        return HeroType.healer;
      case Hero.warrior:
        return HeroType.warrior;
    }

    return null;
  }

  static String string(HeroType type) {
    switch (type) {
      case HeroType.assassin:
        return Hero.assassin;
      case HeroType.healer:
        return Hero.healer;
      case HeroType.warrior:
        return Hero.warrior;
    }

    return 'Unknown HeroType';
  }
}

List<String> allPurchases = ['Aphrodite', 'Apollo', 'Hades', 'Zeus'];

List<Achievement> allAchievements = List.generate(11, (i) => i)
    .map<Achievement>((i) => Achievement(name: 'Achievement $i', total: i))
    .toList();

List<Card> allCards = [
  Card(name: 'Aphrodite'),
  Card(name: 'Apollo'),
  Card(name: 'Ares'),
  Card(name: 'Artemis', hero: HeroType.assassin),
  Card(name: 'Athena', hero: HeroType.assassin),
  Card(name: 'Demeter', hero: HeroType.assassin),
  Card(name: 'Dionysus', hero: HeroType.healer),
  Card(name: 'Hades', hero: HeroType.healer),
  Card(name: 'Hephaestus', hero: HeroType.healer),
  Card(name: 'Hera', hero: HeroType.healer),
  Card(name: 'Hermes', hero: HeroType.warrior),
  Card(name: 'Poseidon', hero: HeroType.warrior),
  Card(name: 'Zeus', hero: HeroType.warrior),
];

List<Deck> myDecks = List.generate(11, (i) => i).map<Deck>((i) {
  HeroType hero = Hero.random();

  final cards = allCards
      .where((card) =>
          rand() &&
          allPurchases.contains(card.name) &&
          (card.hero == null || (card.hero == hero)))
      .map((card) => card.name)
      .toList();

  return Deck(
    id: uuid(),
    name: 'Deck $i',
    hero: hero,
    cards: cards,
  );
}).toList();

bool rand([int i = 2]) => Random().nextInt(i) == 0;

String uuid() => Uuid().v4();

mixin SharedPrefs on Object {
  Future<SharedPreferences> prefs() async => SharedPreferences.getInstance();
}

class SettingsStore = _Settings with _$SettingsStore;

abstract class _Settings with Store, SharedPrefs {
  _Settings() {
    _init();
  }

  Future _init() async {
    sound = (await prefs()).getBool('sound') ?? true;

    music = (await prefs()).getBool('music') ?? true;
  }

  @observable
  bool music = true;

  @observable
  bool sound = true;

  @action
  Future toggleSound() async {
    (await prefs()).setBool('sound', sound = !sound);
  }

  @action
  Future toggleMusic() async {
    (await prefs()).setBool('music', music = !music);
  }
}

class AchievementsStore = _Achievements with _$AchievementsStore;

abstract class _Achievements with Store {
  operator [](int i) => achievements[i];

  @computed
  int get length => achievements.length;

  @observable
  List<Achievement> achievements = List.from(allAchievements);
}

class NewDeckFormStore = _NewDeckFormStore with _$NewDeckFormStore;

abstract class _NewDeckFormStore with Store {
  @observable
  String name = 'New Deck';

  @observable
  HeroType hero = HeroType.assassin;

  @action
  void setNewDeckName(String name) {
    name = name;
  }

  @action
  void setNewDeckHero(HeroType type) {
    hero = type;
  }
}

class UIStore = _UIStore with _$UIStore;

abstract class _UIStore with Store {
  NewDeckFormStore newDeckForm = NewDeckFormStore();

  @observable
  DeckView deckView = DeckView.deckList;

  @observable
  SocialView socialView = SocialView.achievements;

  @observable
  String activeDeckId;

  @observable
  String activeCardId;

  @action
  void setDeckView(DeckView view) {
    deckView = view;
  }

  @action
  void setSocialView(SocialView view) {
    socialView = view;
  }

  @action
  void setActiveDeck(String id) {
    activeDeckId = id;
  }

  @action
  void setActiveCard(String id) {
    activeCardId = id;
  }
}

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store, SharedPrefs {
  _UserStore() {
    _init();
  }

  AchievementsStore achievements = AchievementsStore();

  void _init() async {
    setXp((await prefs()).getInt('xp') ?? 1);

    setCheckpoint((await prefs()).getInt('checkpoint'));

    setGold((await prefs()).getInt('gold'));

    setArena(Arena.type((await prefs()).getString('arena') ?? Arena.square));

    setHero(Hero.type((await prefs()).getString('hero') ?? Hero.assassin));

    setPurchases((await prefs()).getStringList('purchases') ?? allPurchases);
  }

  @observable
  int xp = 0;

  @observable
  int checkpoint = 0;

  @observable
  int gold = 0;

  @observable
  ArenaType arena = ArenaType.square;

  @observable
  HeroType hero = HeroType.assassin;

  @observable
  List<Deck> decks = [];

  @observable
  List<String> purchases = [];

  @action
  Future setXp(int val) async {
    (await prefs()).setInt('xp', xp = val);
  }

  @action
  Future setCheckpoint(int val) async {
    (await prefs()).setInt('checkpoint', checkpoint = val);
  }

  @action
  Future setGold(int val) async {
    (await prefs()).setInt('gold', gold = val);
  }

  @action
  Future addGold(int val) async {
    (await prefs()).setInt('gold', gold += val);
  }

  @action
  Future removeGold(int val) async {
    (await prefs()).setInt('gold', gold -= val);
  }

  @action
  Future setArena(ArenaType type) async {
    arena = type;

    (await prefs()).setString('arena', Arena.string(type));
  }

  @action
  Future setHero(HeroType type) async {
    hero = type;

    (await prefs()).setString('hero', Hero.string(type));
  }

  @action
  Future setPurchases(List<String> p) async {
    (await prefs()).setStringList('purchases', purchases = p);
  }

  @action
  Future purchaseCard(String cardId) async {
    if (!purchases.contains(cardId)) {
      final card = allCards.firstWhere((card) => card.name == cardId);

      if (card != null && card.gold < gold) {
        removeGold(card.gold);
        setPurchases(purchases..add(cardId));
      }
    }
  }

  @action
  Future addDeck(String name, HeroType hero, UIStore ui) async {
    final id = uuid();

    decks = decks
      ..add(Deck(
        id: id,
        name: name,
        hero: hero,
      ));

    ui.setActiveDeck(id);
  }

  @action
  Future removeDeck(String id) async {
    final id = uuid();

    decks = decks..removeWhere((deck) => deck.id == id);
  }

  @action
  void toggleCard(String deckId, String cardId) {
    decks = decks.map((deck) {
      if (deck.id == deckId) {
        deck.cards.contains(cardId)
            ? deck.cards.remove(cardId)
            : deck.cards.add(cardId);
      }

      return deck;
    }).toList();
  }
}

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  SettingsStore settings = SettingsStore();

  UIStore ui = UIStore();

  UserStore user = UserStore();

  @computed
  Card get activeCard {
    return allCards.firstWhere((card) => card.name == ui.activeCardId);
  }

  @computed
  Deck get activeDeck {
    return user.decks.firstWhere((deck) => deck.id == ui.activeDeckId);
  }

  List<DeckCard> deckCards(
    Deck deck,
  ) {
    return allCards
        .where((card) => card.hero == null || card.hero == deck.hero)
        .map(
          (card) => DeckCard(
            card: card,
            isActive: deck.cards.contains(card.name),
            isPurchased: user.purchases.contains(card.name),
          ),
        )
        .toList()
          ..sort(
            (DeckCard a, DeckCard b) =>
                (a.isPurchased ? 1 : 0).compareTo(b.isPurchased ? 1 : 0),
          );
  }
}
