// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$UIState on _UIState, Store {
  final _$_deckViewAtom = Atom(name: '_UIState._deckView');

  @override
  DeckView get _deckView {
    _$_deckViewAtom.context.enforceReadPolicy(_$_deckViewAtom);
    _$_deckViewAtom.reportObserved();
    return super._deckView;
  }

  @override
  set _deckView(DeckView value) {
    _$_deckViewAtom.context.conditionallyRunInAction(() {
      super._deckView = value;
      _$_deckViewAtom.reportChanged();
    }, _$_deckViewAtom, name: '${_$_deckViewAtom.name}_set');
  }

  final _$_socialViewAtom = Atom(name: '_UIState._socialView');

  @override
  SocialView get _socialView {
    _$_socialViewAtom.context.enforceReadPolicy(_$_socialViewAtom);
    _$_socialViewAtom.reportObserved();
    return super._socialView;
  }

  @override
  set _socialView(SocialView value) {
    _$_socialViewAtom.context.conditionallyRunInAction(() {
      super._socialView = value;
      _$_socialViewAtom.reportChanged();
    }, _$_socialViewAtom, name: '${_$_socialViewAtom.name}_set');
  }
}
