// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$SettingsStore on _Settings, Store {
  final _$musicAtom = Atom(name: '_Settings.music');

  @override
  bool get music {
    _$musicAtom.context.enforceReadPolicy(_$musicAtom);
    _$musicAtom.reportObserved();
    return super.music;
  }

  @override
  set music(bool value) {
    _$musicAtom.context.conditionallyRunInAction(() {
      super.music = value;
      _$musicAtom.reportChanged();
    }, _$musicAtom, name: '${_$musicAtom.name}_set');
  }

  final _$soundAtom = Atom(name: '_Settings.sound');

  @override
  bool get sound {
    _$soundAtom.context.enforceReadPolicy(_$soundAtom);
    _$soundAtom.reportObserved();
    return super.sound;
  }

  @override
  set sound(bool value) {
    _$soundAtom.context.conditionallyRunInAction(() {
      super.sound = value;
      _$soundAtom.reportChanged();
    }, _$soundAtom, name: '${_$soundAtom.name}_set');
  }

  final _$toggleSoundAsyncAction = AsyncAction('toggleSound');

  @override
  Future<dynamic> toggleSound() {
    return _$toggleSoundAsyncAction.run(() => super.toggleSound());
  }

  final _$toggleMusicAsyncAction = AsyncAction('toggleMusic');

  @override
  Future<dynamic> toggleMusic() {
    return _$toggleMusicAsyncAction.run(() => super.toggleMusic());
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$AchievementsStore on _Achievements, Store {
  Computed<int> _$lengthComputed;

  @override
  int get length =>
      (_$lengthComputed ??= Computed<int>(() => super.length)).value;

  final _$achievementsAtom = Atom(name: '_Achievements.achievements');

  @override
  List<Achievement> get achievements {
    _$achievementsAtom.context.enforceReadPolicy(_$achievementsAtom);
    _$achievementsAtom.reportObserved();
    return super.achievements;
  }

  @override
  set achievements(List<Achievement> value) {
    _$achievementsAtom.context.conditionallyRunInAction(() {
      super.achievements = value;
      _$achievementsAtom.reportChanged();
    }, _$achievementsAtom, name: '${_$achievementsAtom.name}_set');
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ChestStore on _Chest, Store {
  Computed<DateTime> _$savedComputed;

  @override
  DateTime get saved =>
      (_$savedComputed ??= Computed<DateTime>(() => super.saved)).value;
  Computed<DateTime> _$nowComputed;

  @override
  DateTime get now =>
      (_$nowComputed ??= Computed<DateTime>(() => super.now)).value;
  Computed<Duration> _$durationComputed;

  @override
  Duration get duration =>
      (_$durationComputed ??= Computed<Duration>(() => super.duration)).value;

  final _$timestampSavedAtom = Atom(name: '_Chest.timestampSaved');

  @override
  int get timestampSaved {
    _$timestampSavedAtom.context.enforceReadPolicy(_$timestampSavedAtom);
    _$timestampSavedAtom.reportObserved();
    return super.timestampSaved;
  }

  @override
  set timestampSaved(int value) {
    _$timestampSavedAtom.context.conditionallyRunInAction(() {
      super.timestampSaved = value;
      _$timestampSavedAtom.reportChanged();
    }, _$timestampSavedAtom, name: '${_$timestampSavedAtom.name}_set');
  }

  final _$timestampNowAtom = Atom(name: '_Chest.timestampNow');

  @override
  int get timestampNow {
    _$timestampNowAtom.context.enforceReadPolicy(_$timestampNowAtom);
    _$timestampNowAtom.reportObserved();
    return super.timestampNow;
  }

  @override
  set timestampNow(int value) {
    _$timestampNowAtom.context.conditionallyRunInAction(() {
      super.timestampNow = value;
      _$timestampNowAtom.reportChanged();
    }, _$timestampNowAtom, name: '${_$timestampNowAtom.name}_set');
  }

  final _$setTimestampAsyncAction = AsyncAction('setTimestamp');

  @override
  Future<dynamic> setTimestamp(int t) {
    return _$setTimestampAsyncAction.run(() => super.setTimestamp(t));
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$NewDeckFormStore on _NewDeckFormStore, Store {
  final _$nameAtom = Atom(name: '_NewDeckFormStore.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$heroAtom = Atom(name: '_NewDeckFormStore.hero');

  @override
  HeroType get hero {
    _$heroAtom.context.enforceReadPolicy(_$heroAtom);
    _$heroAtom.reportObserved();
    return super.hero;
  }

  @override
  set hero(HeroType value) {
    _$heroAtom.context.conditionallyRunInAction(() {
      super.hero = value;
      _$heroAtom.reportChanged();
    }, _$heroAtom, name: '${_$heroAtom.name}_set');
  }

  final _$_NewDeckFormStoreActionController =
      ActionController(name: '_NewDeckFormStore');

  @override
  void setNewDeckName(String name) {
    final _$actionInfo = _$_NewDeckFormStoreActionController.startAction();
    try {
      return super.setNewDeckName(name);
    } finally {
      _$_NewDeckFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewDeckHero(HeroType type) {
    final _$actionInfo = _$_NewDeckFormStoreActionController.startAction();
    try {
      return super.setNewDeckHero(type);
    } finally {
      _$_NewDeckFormStoreActionController.endAction(_$actionInfo);
    }
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$PlayFormStore on _PlayFormStore, Store {
  final _$deckIdAtom = Atom(name: '_PlayFormStore.deckId');

  @override
  String get deckId {
    _$deckIdAtom.context.enforceReadPolicy(_$deckIdAtom);
    _$deckIdAtom.reportObserved();
    return super.deckId;
  }

  @override
  set deckId(String value) {
    _$deckIdAtom.context.conditionallyRunInAction(() {
      super.deckId = value;
      _$deckIdAtom.reportChanged();
    }, _$deckIdAtom, name: '${_$deckIdAtom.name}_set');
  }

  final _$_PlayFormStoreActionController =
      ActionController(name: '_PlayFormStore');

  @override
  void setDeckId(String id) {
    final _$actionInfo = _$_PlayFormStoreActionController.startAction();
    try {
      return super.setDeckId(id);
    } finally {
      _$_PlayFormStoreActionController.endAction(_$actionInfo);
    }
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$UIStore on _UIStore, Store {
  final _$playViewAtom = Atom(name: '_UIStore.playView');

  @override
  PlayView get playView {
    _$playViewAtom.context.enforceReadPolicy(_$playViewAtom);
    _$playViewAtom.reportObserved();
    return super.playView;
  }

  @override
  set playView(PlayView value) {
    _$playViewAtom.context.conditionallyRunInAction(() {
      super.playView = value;
      _$playViewAtom.reportChanged();
    }, _$playViewAtom, name: '${_$playViewAtom.name}_set');
  }

  final _$deckViewAtom = Atom(name: '_UIStore.deckView');

  @override
  DeckView get deckView {
    _$deckViewAtom.context.enforceReadPolicy(_$deckViewAtom);
    _$deckViewAtom.reportObserved();
    return super.deckView;
  }

  @override
  set deckView(DeckView value) {
    _$deckViewAtom.context.conditionallyRunInAction(() {
      super.deckView = value;
      _$deckViewAtom.reportChanged();
    }, _$deckViewAtom, name: '${_$deckViewAtom.name}_set');
  }

  final _$socialViewAtom = Atom(name: '_UIStore.socialView');

  @override
  SocialView get socialView {
    _$socialViewAtom.context.enforceReadPolicy(_$socialViewAtom);
    _$socialViewAtom.reportObserved();
    return super.socialView;
  }

  @override
  set socialView(SocialView value) {
    _$socialViewAtom.context.conditionallyRunInAction(() {
      super.socialView = value;
      _$socialViewAtom.reportChanged();
    }, _$socialViewAtom, name: '${_$socialViewAtom.name}_set');
  }

  final _$activeDeckIdAtom = Atom(name: '_UIStore.activeDeckId');

  @override
  String get activeDeckId {
    _$activeDeckIdAtom.context.enforceReadPolicy(_$activeDeckIdAtom);
    _$activeDeckIdAtom.reportObserved();
    return super.activeDeckId;
  }

  @override
  set activeDeckId(String value) {
    _$activeDeckIdAtom.context.conditionallyRunInAction(() {
      super.activeDeckId = value;
      _$activeDeckIdAtom.reportChanged();
    }, _$activeDeckIdAtom, name: '${_$activeDeckIdAtom.name}_set');
  }

  final _$activeCardIdAtom = Atom(name: '_UIStore.activeCardId');

  @override
  String get activeCardId {
    _$activeCardIdAtom.context.enforceReadPolicy(_$activeCardIdAtom);
    _$activeCardIdAtom.reportObserved();
    return super.activeCardId;
  }

  @override
  set activeCardId(String value) {
    _$activeCardIdAtom.context.conditionallyRunInAction(() {
      super.activeCardId = value;
      _$activeCardIdAtom.reportChanged();
    }, _$activeCardIdAtom, name: '${_$activeCardIdAtom.name}_set');
  }

  final _$_UIStoreActionController = ActionController(name: '_UIStore');

  @override
  void setPlayView(PlayView view) {
    final _$actionInfo = _$_UIStoreActionController.startAction();
    try {
      return super.setPlayView(view);
    } finally {
      _$_UIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeckView(DeckView view) {
    final _$actionInfo = _$_UIStoreActionController.startAction();
    try {
      return super.setDeckView(view);
    } finally {
      _$_UIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSocialView(SocialView view) {
    final _$actionInfo = _$_UIStoreActionController.startAction();
    try {
      return super.setSocialView(view);
    } finally {
      _$_UIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveDeck(String id) {
    final _$actionInfo = _$_UIStoreActionController.startAction();
    try {
      return super.setActiveDeck(id);
    } finally {
      _$_UIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveCard(String id) {
    final _$actionInfo = _$_UIStoreActionController.startAction();
    try {
      return super.setActiveCard(id);
    } finally {
      _$_UIStoreActionController.endAction(_$actionInfo);
    }
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$UserStore on _UserStore, Store {
  final _$xpAtom = Atom(name: '_UserStore.xp');

  @override
  int get xp {
    _$xpAtom.context.enforceReadPolicy(_$xpAtom);
    _$xpAtom.reportObserved();
    return super.xp;
  }

  @override
  set xp(int value) {
    _$xpAtom.context.conditionallyRunInAction(() {
      super.xp = value;
      _$xpAtom.reportChanged();
    }, _$xpAtom, name: '${_$xpAtom.name}_set');
  }

  final _$checkpointAtom = Atom(name: '_UserStore.checkpoint');

  @override
  int get checkpoint {
    _$checkpointAtom.context.enforceReadPolicy(_$checkpointAtom);
    _$checkpointAtom.reportObserved();
    return super.checkpoint;
  }

  @override
  set checkpoint(int value) {
    _$checkpointAtom.context.conditionallyRunInAction(() {
      super.checkpoint = value;
      _$checkpointAtom.reportChanged();
    }, _$checkpointAtom, name: '${_$checkpointAtom.name}_set');
  }

  final _$goldAtom = Atom(name: '_UserStore.gold');

  @override
  int get gold {
    _$goldAtom.context.enforceReadPolicy(_$goldAtom);
    _$goldAtom.reportObserved();
    return super.gold;
  }

  @override
  set gold(int value) {
    _$goldAtom.context.conditionallyRunInAction(() {
      super.gold = value;
      _$goldAtom.reportChanged();
    }, _$goldAtom, name: '${_$goldAtom.name}_set');
  }

  final _$arenaAtom = Atom(name: '_UserStore.arena');

  @override
  ArenaType get arena {
    _$arenaAtom.context.enforceReadPolicy(_$arenaAtom);
    _$arenaAtom.reportObserved();
    return super.arena;
  }

  @override
  set arena(ArenaType value) {
    _$arenaAtom.context.conditionallyRunInAction(() {
      super.arena = value;
      _$arenaAtom.reportChanged();
    }, _$arenaAtom, name: '${_$arenaAtom.name}_set');
  }

  final _$heroAtom = Atom(name: '_UserStore.hero');

  @override
  HeroType get hero {
    _$heroAtom.context.enforceReadPolicy(_$heroAtom);
    _$heroAtom.reportObserved();
    return super.hero;
  }

  @override
  set hero(HeroType value) {
    _$heroAtom.context.conditionallyRunInAction(() {
      super.hero = value;
      _$heroAtom.reportChanged();
    }, _$heroAtom, name: '${_$heroAtom.name}_set');
  }

  final _$decksAtom = Atom(name: '_UserStore.decks');

  @override
  List<Deck> get decks {
    _$decksAtom.context.enforceReadPolicy(_$decksAtom);
    _$decksAtom.reportObserved();
    return super.decks;
  }

  @override
  set decks(List<Deck> value) {
    _$decksAtom.context.conditionallyRunInAction(() {
      super.decks = value;
      _$decksAtom.reportChanged();
    }, _$decksAtom, name: '${_$decksAtom.name}_set');
  }

  final _$purchasesAtom = Atom(name: '_UserStore.purchases');

  @override
  List<String> get purchases {
    _$purchasesAtom.context.enforceReadPolicy(_$purchasesAtom);
    _$purchasesAtom.reportObserved();
    return super.purchases;
  }

  @override
  set purchases(List<String> value) {
    _$purchasesAtom.context.conditionallyRunInAction(() {
      super.purchases = value;
      _$purchasesAtom.reportChanged();
    }, _$purchasesAtom, name: '${_$purchasesAtom.name}_set');
  }

  final _$setXpAsyncAction = AsyncAction('setXp');

  @override
  Future<dynamic> setXp(int val) {
    return _$setXpAsyncAction.run(() => super.setXp(val));
  }

  final _$setCheckpointAsyncAction = AsyncAction('setCheckpoint');

  @override
  Future<dynamic> setCheckpoint(int val) {
    return _$setCheckpointAsyncAction.run(() => super.setCheckpoint(val));
  }

  final _$setGoldAsyncAction = AsyncAction('setGold');

  @override
  Future<dynamic> setGold(int val) {
    return _$setGoldAsyncAction.run(() => super.setGold(val));
  }

  final _$addGoldAsyncAction = AsyncAction('addGold');

  @override
  Future<dynamic> addGold(int val) {
    return _$addGoldAsyncAction.run(() => super.addGold(val));
  }

  final _$subtractGoldAsyncAction = AsyncAction('subtractGold');

  @override
  Future<dynamic> subtractGold(int val) {
    return _$subtractGoldAsyncAction.run(() => super.subtractGold(val));
  }

  final _$setArenaAsyncAction = AsyncAction('setArena');

  @override
  Future<dynamic> setArena(ArenaType type) {
    return _$setArenaAsyncAction.run(() => super.setArena(type));
  }

  final _$setHeroAsyncAction = AsyncAction('setHero');

  @override
  Future<dynamic> setHero(HeroType type) {
    return _$setHeroAsyncAction.run(() => super.setHero(type));
  }

  final _$setPurchasesAsyncAction = AsyncAction('setPurchases');

  @override
  Future<dynamic> setPurchases(List<String> p) {
    return _$setPurchasesAsyncAction.run(() => super.setPurchases(p));
  }

  final _$purchaseCardAsyncAction = AsyncAction('purchaseCard');

  @override
  Future<dynamic> purchaseCard(String cardId) {
    return _$purchaseCardAsyncAction.run(() => super.purchaseCard(cardId));
  }

  final _$setDecksAsyncAction = AsyncAction('setDecks');

  @override
  Future<dynamic> setDecks(List<Deck> d) {
    return _$setDecksAsyncAction.run(() => super.setDecks(d));
  }

  final _$addDeckAsyncAction = AsyncAction('addDeck');

  @override
  Future<dynamic> addDeck(Deck deck) {
    return _$addDeckAsyncAction.run(() => super.addDeck(deck));
  }

  final _$removeDeckAsyncAction = AsyncAction('removeDeck');

  @override
  Future<dynamic> removeDeck(String id) {
    return _$removeDeckAsyncAction.run(() => super.removeDeck(id));
  }

  final _$renameDeckAsyncAction = AsyncAction('renameDeck');

  @override
  Future<dynamic> renameDeck(String id, String name) {
    return _$renameDeckAsyncAction.run(() => super.renameDeck(id, name));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void toggleCard(String deckId, String cardId) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.toggleCard(deckId, cardId);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }
}

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$AppState on _AppState, Store {
  Computed<List<Card>> _$cardsComputed;

  @override
  List<Card> get cards =>
      (_$cardsComputed ??= Computed<List<Card>>(() => super.cards)).value;
  Computed<Deck> _$activeDeckComputed;

  @override
  Deck get activeDeck =>
      (_$activeDeckComputed ??= Computed<Deck>(() => super.activeDeck)).value;
  Computed<List<Card>> _$activeDeckCardsComputed;

  @override
  List<Card> get activeDeckCards => (_$activeDeckCardsComputed ??=
          Computed<List<Card>>(() => super.activeDeckCards))
      .value;
}
