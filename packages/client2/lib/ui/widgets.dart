import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

abstract class RenderLoopCallbacks {
  void lifecycleChange(AppLifecycleState state) {}

  void render(Canvas canvas) {}

  void resize(Size size) {}

  void update(double dt) {}
}

class RenderWidget extends LeafRenderObjectWidget {
  final RenderLoopCallbacks callbacks;
  final Size size;

  RenderWidget(
    this.callbacks, {
    this.size,
  });

  _constrain(RenderWidget widget) {
    return BoxConstraints.expand(
      width: widget.size?.width,
      height: widget.size?.height,
    );
  }

  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      child: RenderLoop(context, this.callbacks),
      additionalConstraints: _constrain(this),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox box) {
    box
      ..child = RenderLoop(context, this.callbacks)
      ..additionalConstraints = _constrain(this);
  }
}

class RenderLoop extends RenderBox with WidgetsBindingObserver {
  int _callbackId;

  BuildContext context;

  RenderLoopCallbacks callbacks;

  Duration previous = Duration.zero;

  RenderLoop(this.context, this.callbacks);

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();

    callbacks.resize(constraints.biggest);
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

    callbacks.lifecycleChange(state);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    context.canvas.save();

    context.canvas.translate(offset.dx, offset.dy);

    callbacks.render(context.canvas);

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

    Duration delta = now - previous;

    if (previous == Duration.zero) {
      delta = Duration.zero;
    }

    previous = now;

    double dt = delta.inMicroseconds / Duration.microsecondsPerSecond;

    callbacks.update(dt);

    markNeedsPaint();
  }
}
