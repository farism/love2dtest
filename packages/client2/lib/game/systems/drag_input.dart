import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import './base/input_system.dart';
import '../../ecs/ecs.dart';
import '../components/drag_input.dart';
import '../flags.dart';

class DragInputSystem extends InputSystem {
  static const int Flag = SystemFlags.Drag;
  int flag = DragInputSystem.Flag;

  static const String Id = 'DragInputSystem';
  String id = DragInputSystem.Id;

  Aspect aspect = Aspect(all: [DragInput.Flag]);

  DragInputSystem();

  @override
  void onScaleStart(ScaleStartDetails details) {
    entities.values.forEach((entity) {
      final dragInput = entity.as<DragInput>(DragInput.Id);

      dragInput.current = dragInput.end = null;

      dragInput.start = Vector2(details.focalPoint.dx, details.focalPoint.dy);
    });
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details) {
    entities.values.forEach((entity) {
      final dragInput = entity.as<DragInput>(DragInput.Id);

      dragInput.current = Vector2(details.focalPoint.dx, details.focalPoint.dy);
    });
  }

  @override
  void onScaleEnd(ScaleEndDetails details) {
    entities.values.forEach((entity) {
      final dragInput = entity.as<DragInput>(DragInput.Id);

      dragInput.end = dragInput.current;
    });
  }
}
