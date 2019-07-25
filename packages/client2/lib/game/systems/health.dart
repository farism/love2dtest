import 'dart:ui';

import 'package:flutter/rendering.dart';

import './base/render_system.dart';
import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/health.dart';
import '../components/position.dart';
import '../flags.dart';

class HealthSystem extends RenderSystem {
  static const int Flag = SystemFlags.Health;
  int flag = HealthSystem.Flag;

  static const String Id = 'HealthSystem';
  String id = HealthSystem.Id;

  Aspect aspect = Aspect(all: [Health.Flag, Position.Flag]);

  Camera camera;

  HealthSystem(this.camera);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {
      final health = entity.as<Health>(Health.Id);
      final pos = entity.as<Position>(Position.Id);

      if (health == null || pos == null) {
        return;
      }

      final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: health.hitpoints.toString(),
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
          ),
        ),
      );

      textPainter
        ..layout()
        ..paint(
          canvas,
          Offset(pos.x - textPainter.width / 2, pos.y - textPainter.height / 2),
        );
    });
  }
}
