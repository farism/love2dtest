import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import './render_loop.dart';

class RenderWidget extends LeafRenderObjectWidget {
  final RenderLoopListener callbacks;
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
