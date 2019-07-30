import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import './base/input_system.dart';
import '../../ecs/ecs.dart';
import '../components/input.dart';
import '../flags.dart';

class InputDrag extends InputSystem {
  static const int Flag = SystemFlags.InputDrag;
  int flag = InputDrag.Flag;

  static const String Id = 'InputDrag';
  String id = InputDrag.Id;

  Aspect aspect = Aspect(all: [Input.Flag]);

  InputDrag();

  @override
  void onScaleStart(ScaleStartDetails details) {
    entities.values.forEach((entity) {
      final input = entity.as<Input>(Input.Id);

      input.dragCurrent = input.dragEnd = null;

      input.dragStart = Vector2(details.focalPoint.dx, details.focalPoint.dy);
    });
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details) {
    entities.values.forEach((entity) {
      final input = entity.as<Input>(Input.Id);

      input.dragCurrent = Vector2(details.focalPoint.dx, details.focalPoint.dy);
    });
  }

  @override
  void onScaleEnd(ScaleEndDetails details) {
    entities.values.forEach((entity) {
      final input = entity.as<Input>(Input.Id);

      input.dragEnd = input.dragCurrent;
    });
  }
}
