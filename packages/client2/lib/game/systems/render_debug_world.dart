import 'dart:math';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';

import './base/render_system.dart';
import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/game_object.dart';
import '../flags.dart';

class RenderDebugWorld extends RenderSystem {
  static const int Flag = SystemFlags.RenderDebugWorld;
  int flag = RenderDebugWorld.Flag;

  static const String Id = 'RenderDebugWorld';
  String id = RenderDebugWorld.Id;

  Camera camera;

  Aspect aspect = Aspect(all: [
    GameObject.Flag,
  ]);

  RenderDebugWorld(this.camera);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {
      final gameObject = entity.as<GameObject>(GameObject.Id);

      if (gameObject == null) {
        return;
      }

      final body = gameObject.body;

      for (var fixture = body.getFixtureList();
          fixture != null;
          fixture = fixture.getNext()) {
        ShapeType type = fixture.getType();

        if (type == ShapeType.CHAIN) {
          final ChainShape shape = fixture.getShape();

          for (var i = 1; i < shape.getVertexCount(); i++) {
            final v1 = shape.getVertex(i - 1);
            final v2 = shape.getVertex(i);

            if (v1 != null && v2 != null) {
              final p1 = camera.project(body, v1);
              final p2 = camera.project(body, v2);

              canvas.drawLine(
                Offset(p1.x, p1.y),
                Offset(p2.x, p2.y),
                Paint()..color = Color(0xFFFFFFFF),
              );
            }
          }
        } else if (type == ShapeType.CIRCLE) {
          final CircleShape shape = fixture.getShape();
          final center = camera.project(body, shape.p);

          canvas.drawCircle(
              Offset(center.x, center.y),
              shape.radius * camera.scale,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = Color(0xFFFFFFFF));
        } else if (type == ShapeType.EDGE) {
        } else if (type == ShapeType.POLYGON) {}
      }
    });
  }
}
