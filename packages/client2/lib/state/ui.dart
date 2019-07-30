import 'package:mobx/mobx.dart';

part 'ui.g.dart';

class UIState = _UIState with _$UIState;

enum DeckView {
  deckList,
  cardIndex,
}

enum SocialView {
  challenge,
  trade,
  team,
}

abstract class _UIState with Store {
  @observable
  DeckView _deckView = DeckView.deckList;
  DeckView get deckView => _deckView;

  void setDeckView(DeckView view) {
    _deckView = view;
  }

  @observable
  SocialView _socialView = SocialView.challenge;
  SocialView get socialView => _socialView;

  void setSocialView(SocialView view) {
    _socialView = view;
  }
}
