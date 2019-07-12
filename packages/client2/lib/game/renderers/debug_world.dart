import 'dart:ui';
import 'package:client2/ecs/manager.dart';

import '../../ecs/aspect.dart';
import '../../ecs/renderer.dart';
import '../camera.dart';
import '../components/game_object.dart';
import '../flags.dart';

class DebugWorld extends Renderer {
  static const int Flag = RendererFlags.DebugWorld;
  int flag = DebugWorld.Flag;

  static const String Id = 'DebugWorld';
  String id = DebugWorld.Id;

  Camera camera;

  DebugWorld(Manager manager, this.camera) : super(manager);

  Aspect aspect = Aspect(all: [
    GameObject.Flag,
  ]);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {
      final gameObject = entity.as<GameObject>(GameObject.Id);

      if (gameObject == null) {
        return;
      }

      // final body = gameObject.body;

      // body.getFixtureList();

      // for (Fixture fixture = body.getFixtureList();
      //     fixture != null;
      //     fixture = fixture.getNext()) {
      //   switch (fixture.getType()) {
      //     case ShapeType.CHAIN:
      //       throw Exception('not implemented');
      //       break;
      //     case ShapeType.CIRCLE:
      //       _renderCircle(canvas, camera, body, fixture);
      //       break;
      //     case ShapeType.EDGE:
      //       throw Exception('not implemented');
      //       break;
      //     case ShapeType.POLYGON:
      //       _renderPolygon(canvas, camera, body, fixture);
      //       break;
      //   }
      // }
    });
  }

  // void _renderCircle(Canvas canvas, Camera camera, Body body, Fixture fixture) {
  //   final Vector2 center = Vector2.zero();
  //   final CircleShape circle = fixture.getShape();
  //   body.getWorldPointToOut(circle.p, center);
  //   camera.getWorldToScreen(center, center);
  //   renderCircle(
  //       canvas, Offset(center.x, center.y), circle.radius * camera.scale);
  // }

  // void renderCircle(Canvas canvas, Offset center, double radius) {
  //   final Paint paint = Paint()
  //     ..color = const Color.fromARGB(255, 255, 255, 255);
  //   canvas.drawCircle(center, radius, paint);
  // }

  // void _renderPolygon(
  //     Canvas canvas, Camera camera, Body body, Fixture fixture) {
  //   final PolygonShape polygon = fixture.getShape();
  //   assert(polygon.count <= 10);
  //   final List<Vector2> vertices = Vec2Array().get(polygon.count);

  //   // print(polygon.count);

  //   for (int i = 0; i < polygon.count; ++i) {
  //     body.getWorldPointToOut(polygon.vertices[i], vertices[i]);
  //     camera.getWorldToScreen(vertices[i], vertices[i]);
  //   }

  //   final List<Offset> points = [];
  //   for (int i = 0; i < polygon.count; i++) {
  //     points.add(Offset(vertices[i].x, vertices[i].y));
  //   }

  //   if (points.length == 2) {
  //     renderLine(canvas, points);
  //   } else if (points.length >= 3) {
  //     renderPolygon(canvas, points);
  //   }
  // }

  // void renderLine(Canvas canvas, List<Offset> points) {
  //   canvas.drawLine(points[0], points[1], Paint()..color = Color(0xFFFFFFFF));
  // }

  // void renderPolygon(Canvas canvas, List<Offset> points) {
  //   final path = Path()..addPolygon(points, true);
  //   final Paint paint = Paint()
  //     ..color = const Color.fromARGB(255, 255, 255, 255);
  //   canvas.drawPath(path, paint);
  // }
}
