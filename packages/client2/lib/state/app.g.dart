// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$AppState on _AppState, Store {
  final _$_musicAtom = Atom(name: '_AppState._music');

  @override
  bool get _music {
    _$_musicAtom.context.enforceReadPolicy(_$_musicAtom);
    _$_musicAtom.reportObserved();
    return super._music;
  }

  @override
  set _music(bool value) {
    _$_musicAtom.context.conditionallyRunInAction(() {
      super._music = value;
      _$_musicAtom.reportChanged();
    }, _$_musicAtom, name: '${_$_musicAtom.name}_set');
  }

  final _$_soundAtom = Atom(name: '_AppState._sound');

  @override
  bool get _sound {
    _$_soundAtom.context.enforceReadPolicy(_$_soundAtom);
    _$_soundAtom.reportObserved();
    return super._sound;
  }

  @override
  set _sound(bool value) {
    _$_soundAtom.context.conditionallyRunInAction(() {
      super._sound = value;
      _$_soundAtom.reportChanged();
    }, _$_soundAtom, name: '${_$_soundAtom.name}_set');
  }

  final _$_mapAtom = Atom(name: '_AppState._map');

  @override
  ArenaType get _map {
    _$_mapAtom.context.enforceReadPolicy(_$_mapAtom);
    _$_mapAtom.reportObserved();
    return super._map;
  }

  @override
  set _map(ArenaType value) {
    _$_mapAtom.context.conditionallyRunInAction(() {
      super._map = value;
      _$_mapAtom.reportChanged();
    }, _$_mapAtom, name: '${_$_mapAtom.name}_set');
  }

  final _$_heroAtom = Atom(name: '_AppState._hero');

  @override
  HeroType get _hero {
    _$_heroAtom.context.enforceReadPolicy(_$_heroAtom);
    _$_heroAtom.reportObserved();
    return super._hero;
  }

  @override
  set _hero(HeroType value) {
    _$_heroAtom.context.conditionallyRunInAction(() {
      super._hero = value;
      _$_heroAtom.reportChanged();
    }, _$_heroAtom, name: '${_$_heroAtom.name}_set');
  }

  final _$_xpAtom = Atom(name: '_AppState._xp');

  @override
  int get _xp {
    _$_xpAtom.context.enforceReadPolicy(_$_xpAtom);
    _$_xpAtom.reportObserved();
    return super._xp;
  }

  @override
  set _xp(int value) {
    _$_xpAtom.context.conditionallyRunInAction(() {
      super._xp = value;
      _$_xpAtom.reportChanged();
    }, _$_xpAtom, name: '${_$_xpAtom.name}_set');
  }

  final _$_checkpointAtom = Atom(name: '_AppState._checkpoint');

  @override
  int get _checkpoint {
    _$_checkpointAtom.context.enforceReadPolicy(_$_checkpointAtom);
    _$_checkpointAtom.reportObserved();
    return super._checkpoint;
  }

  @override
  set _checkpoint(int value) {
    _$_checkpointAtom.context.conditionallyRunInAction(() {
      super._checkpoint = value;
      _$_checkpointAtom.reportChanged();
    }, _$_checkpointAtom, name: '${_$_checkpointAtom.name}_set');
  }

  final _$_coinsAtom = Atom(name: '_AppState._coins');

  @override
  int get _coins {
    _$_coinsAtom.context.enforceReadPolicy(_$_coinsAtom);
    _$_coinsAtom.reportObserved();
    return super._coins;
  }

  @override
  set _coins(int value) {
    _$_coinsAtom.context.conditionallyRunInAction(() {
      super._coins = value;
      _$_coinsAtom.reportChanged();
    }, _$_coinsAtom, name: '${_$_coinsAtom.name}_set');
  }

  final _$_gemsAtom = Atom(name: '_AppState._gems');

  @override
  int get _gems {
    _$_gemsAtom.context.enforceReadPolicy(_$_gemsAtom);
    _$_gemsAtom.reportObserved();
    return super._gems;
  }

  @override
  set _gems(int value) {
    _$_gemsAtom.context.conditionallyRunInAction(() {
      super._gems = value;
      _$_gemsAtom.reportChanged();
    }, _$_gemsAtom, name: '${_$_gemsAtom.name}_set');
  }

  final _$_cardsAtom = Atom(name: '_AppState._cards');

  @override
  List<Card> get _cards {
    _$_cardsAtom.context.enforceReadPolicy(_$_cardsAtom);
    _$_cardsAtom.reportObserved();
    return super._cards;
  }

  @override
  set _cards(List<Card> value) {
    _$_cardsAtom.context.conditionallyRunInAction(() {
      super._cards = value;
      _$_cardsAtom.reportChanged();
    }, _$_cardsAtom, name: '${_$_cardsAtom.name}_set');
  }

  final _$_decksAtom = Atom(name: '_AppState._decks');

  @override
  List<MyDeck> get _decks {
    _$_decksAtom.context.enforceReadPolicy(_$_decksAtom);
    _$_decksAtom.reportObserved();
    return super._decks;
  }

  @override
  set _decks(List<MyDeck> value) {
    _$_decksAtom.context.conditionallyRunInAction(() {
      super._decks = value;
      _$_decksAtom.reportChanged();
    }, _$_decksAtom, name: '${_$_decksAtom.name}_set');
  }

  final _$_AppStateActionController = ActionController(name: '_AppState');

  @override
  void toggleMusic() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.toggleMusic();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSound() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.toggleSound();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMap(ArenaType type) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setMap(type);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHero(HeroType type) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setHero(type);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCoins(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setCoins(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCoins(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addCoins(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCoins(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.removeCoins(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGems(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.setGems(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addGems(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.addGems(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeGems(int val) {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.removeGems(val);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }
}
