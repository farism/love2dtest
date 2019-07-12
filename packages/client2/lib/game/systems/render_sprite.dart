import 'dart:ui';

import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/game_object.dart';
import '../flags.dart';

class RenderSprite extends RenderingSystem {
  static const int Flag = RenderingSystemFlags.RenderSprite;
  int flag = RenderSprite.Flag;

  static const String Id = 'RenderSprite';
  String id = RenderSprite.Id;

  Camera camera;

  RenderSprite(Manager manager, this.camera) : super(manager);

  Aspect aspect = Aspect(all: [
    GameObject.Flag,
  ]);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {});
  }
}
