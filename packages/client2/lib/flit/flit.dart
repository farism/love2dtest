import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

import './rendering/camera.dart';
import './ecs/component.dart';
import './ecs/entity.dart';
import './ecs/manager.dart';
import './ecs/renderer.dart';
import './ecs/system.dart';

export "./ecs/ecs.dart";
export "./rendering/rendering.dart";

class Game {
  Camera camera;
  Manager manager;
  World world;

  Game({
    double gravity = 10,
    double screenHeight = 768,
    double screenWidth = 1024,
    double screenPPM = 32,
    List<Renderer> renderers = const [],
    List<System> systems = const [],
  }) {
    camera = Camera(Size(screenWidth, screenHeight), screenPPM);
    manager = Manager(this, renderers: renderers, systems: systems);
    world = World.withGravity(Vector2(0, gravity));
  }

  // camera shortcuts

  // manager shortcuts

  Entity createEntity([bool add = true]) {
    return manager.createEntity(add);
  }

  T getComponent<T extends Component>(Entity entity, String id) {
    return manager.getComponent<T>(entity, id);
  }

  void addComponent(Entity entity, Component component) {
    manager.addComponent(entity, component);
  }

  void removeComponent(Entity entity, Component component) {
    manager.removeComponent(entity, component);
  }

  // widget callbacks

  void resize(Size size) {
    camera.resize(size);
  }

  void render(Canvas canvas) {
    this.manager.render(canvas, camera);
  }

  void update(double dt) {
    this.world.stepDt(dt, 10, 10);
    this.manager.update(dt);
  }

  void lifecycle(AppLifecycleState state) {}

  Widget get widget {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GameWidget(this),
    );
  }
}

class GameWidget extends LeafRenderObjectWidget {
  final Game game;
  final Size size;

  GameWidget(
    this.game, {
    this.size,
  });

  _constrain(GameWidget widget) {
    return BoxConstraints.expand(
      width: widget.size?.width,
      height: widget.size?.height,
    );
  }

  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      child: GameRenderer(context, this.game),
      additionalConstraints: _constrain(this),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox box) {
    box
      ..child = GameRenderer(context, this.game)
      ..additionalConstraints = _constrain(this);
  }
}

class GameRenderer extends RenderBox with WidgetsBindingObserver {
  int _callbackId;

  BuildContext context;

  Game game;

  Duration previous = Duration.zero;

  GameRenderer(this.context, this.game);

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();

    game.resize(constraints.biggest);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    _scheduleTick();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void detach() {
    super.detach();

    _cancelTick();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    game.lifecycle(state);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    context.canvas.save();

    context.canvas.translate(offset.dx, offset.dy);

    game.render(context.canvas);

    context.canvas.restore();
  }

  void _scheduleTick() {
    _callbackId = SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  void _cancelTick() {
    SchedulerBinding.instance.cancelFrameCallbackWithId(_callbackId);
  }

  void _tick(Duration now) {
    if (!attached) {
      return;
    }

    _scheduleTick();

    _update(now);

    markNeedsPaint();
  }

  void _update(Duration now) {
    Duration delta = now - previous;

    if (previous == Duration.zero) {
      delta = Duration.zero;
    }

    previous = now;

    double dt = delta.inMicroseconds / Duration.microsecondsPerSecond;

    game.update(dt);
  }
}
