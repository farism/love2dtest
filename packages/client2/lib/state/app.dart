import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app.g.dart';

const String defaultDescription =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut cursus dui eget turpis mollis fermentum. Donec porta felis imperdiet egestas porttitor.';

enum PlayView {
  strategy,
  timed,
}

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
    this.active = false,
    this.purchased = false,
  });

  final String name;

  final HeroType hero;

  int gold;

  String description;

  bool purchased = false;

  bool active = false;

  String get heroString => Hero.string(hero);
}

class Deck {
  Deck({this.id, this.name, this.hero, this.cards}) {
    cards ??= [];
  }

  String id;

  HeroType hero;

  String name;

  List<String> cards;

  String get category => hero != null ? Hero.string(hero) : 'General';

  Deck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hero = Hero.type(json['hero']);
    cards = ((jsonDecode(json['cards']) ?? []) as Iterable).cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hero': Hero.string(hero),
      'cards': jsonEncode(cards),
    };
  }
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

    return 'General';
  }
}

// String decksToJSON(List<Deck> decks) {
//   jsonEncode(decks);
// }

// List<Deck> decksFromJSON(String str) {}

List<Achievement> allAchievements = List.generate(11, (i) => i)
    .map<Achievement>((i) => Achievement(name: 'Achievement $i', total: i))
    .toList();

List<Card> allCards = [
  Card(name: 'Aphrodite', gold: 10),
  Card(name: 'Apollo', gold: 50),
  Card(name: 'Ares', gold: 100),
  Card(name: 'Artemis', hero: HeroType.assassin, gold: 10),
  Card(name: 'Athena', hero: HeroType.assassin, gold: 50),
  Card(name: 'Demeter', hero: HeroType.assassin, gold: 100),
  Card(name: 'Dionysus', hero: HeroType.healer, gold: 10),
  Card(name: 'Hades', hero: HeroType.healer, gold: 50),
  Card(name: 'Hephaestus', hero: HeroType.healer, gold: 100),
  Card(name: 'Hera', hero: HeroType.healer, gold: 200),
  Card(name: 'Hermes', hero: HeroType.warrior, gold: 10),
  Card(name: 'Poseidon', hero: HeroType.warrior, gold: 50),
  Card(name: 'Zeus', hero: HeroType.warrior, gold: 100),
];

List<String> allPurchases = ['Aphrodite', 'Apollo', 'Athena', 'Hades', 'Zeus'];

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

class ChestStore = _Chest with _$ChestStore;

abstract class _Chest with Store, SharedPrefs {
  _Chest() {
    _init();
  }

  Future _init() async {
    setTimestamp((await prefs()).getInt('timestamp') ?? _now());

    Timer.periodic(Duration(seconds: 1), (timer) => timestampNow = _now());
  }

  int _now() => DateTime.now().millisecondsSinceEpoch;

  @observable
  int timestampSaved;

  @observable
  int timestampNow;

  @computed
  DateTime get saved => DateTime.fromMillisecondsSinceEpoch(timestampSaved);

  @computed
  DateTime get now => DateTime.fromMillisecondsSinceEpoch(timestampNow);

  @computed
  Duration get duration => saved.add(Duration(minutes: 30)).difference(now);

  @action
  Future setTimestamp(int t) async {
    (await prefs()).setInt('timestamp', timestampSaved = t);
  }
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

class PlayFormStore = _PlayFormStore with _$PlayFormStore;

abstract class _PlayFormStore with Store {
  @observable
  String deckId;

  // @observable
  // PlayMode mode;

  @action
  void setDeckId(String id) {
    deckId = deckId;
  }

  // @action
  // void setMode(PlayMode mode) {
  //   mode = mode;
  // }
}

class UIStore = _UIStore with _$UIStore;

abstract class _UIStore with Store {
  NewDeckFormStore newDeckForm = NewDeckFormStore();

  @observable
  PlayView playView;

  @observable
  DeckView deckView = DeckView.deckList;

  @observable
  SocialView socialView = SocialView.achievements;

  @observable
  String activeDeckId;

  @observable
  String activeCardId;

  @action
  void setPlayView(PlayView view) {
    playView = view;
  }

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
    final p = await prefs();

    setXp(p.getInt('xp') ?? 1);

    setCheckpoint(p.getInt('checkpoint') ?? 1);

    setGold(p.getInt('gold') ?? 0);

    setArena(Arena.type(p.getString('arena') ?? Arena.square));

    setHero(Hero.type(p.getString('hero') ?? Hero.assassin));

    setPurchases(p.getStringList('purchases') ?? allPurchases);

    setDecks(
      ((jsonDecode(p.getString('decks')) ?? []) as Iterable)
          .map((deck) => Deck.fromJson(deck))
          .toList(),
    );
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
  Future subtractGold(int val) async {
    if (val > gold) {
      throw Error();
    }

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
    if (purchases.contains(cardId)) {
      return;
    }

    allCards.forEach((card) {
      if (card.name == cardId && card.gold <= gold) {
        subtractGold(card.gold);
        setPurchases(purchases..add(cardId));
      }
    });
  }

  @action
  Future setDecks(List<Deck> d) async {
    (await prefs()).setString('decks', jsonEncode(d));

    decks = d;
  }

  @action
  Future addDeck(Deck deck) async {
    final newDecks = decks..add(deck);

    setDecks(newDecks);
  }

  @action
  Future removeDeck(String id) async {
    final newDecks = decks..removeWhere((deck) => deck.id == id);

    setDecks(newDecks);
  }

  @action
  Future renameDeck(String id, String name) async {
    final newDecks = decks.map((deck) {
      if (deck.id == id) {
        deck.name = name;
      }

      return deck;
    }).toList();

    setDecks(newDecks);
  }

  @action
  void toggleCard(String deckId, String cardId) {
    final newDecks = decks.map((deck) {
      if (deck.id == deckId) {
        if (deck.cards.contains(cardId)) {
          deck.cards.remove(cardId);
        } else {
          deck.cards.add(cardId);
        }
      }

      return deck;
    }).toList();

    setDecks(newDecks);
  }
}

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  ChestStore chest = ChestStore();

  SettingsStore settings = SettingsStore();

  UIStore ui = UIStore();

  UserStore user = UserStore();

  @computed
  List<Card> get cards {
    return allCards
        .map((card) => card..purchased = user.purchases.contains(card.name))
        .toList();
  }

  @computed
  Deck get activeDeck {
    return user.decks.firstWhere((deck) => deck.id == ui.activeDeckId);
  }

  @computed
  List<Card> get activeDeckCards {
    final deck = user.decks.firstWhere((deck) => deck.id == ui.activeDeckId);

    if (deck == null) {
      return [];
    }

    return cards
        .map((card) => card..active = deck.cards.contains(card.name))
        .toList();
  }
}
