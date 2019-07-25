import 'package:flutter/widgets.dart';

enum GestureType {
  onScaleEnd,
  onScaleStart,
  onScaleUpdate,
  onTap,
  onTapCancel,
  onTapDown,
  onTapUp
}

abstract class GestureListener {
  void gesture(GestureType type, [dynamic details]);
}

class GestureWidget extends StatelessWidget {
  final Widget child;
  final GestureListener listener;

  GestureWidget({this.child, this.listener});

  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onScaleEnd: (_) => listener.gesture(GestureType.onScaleEnd, _),
      onScaleStart: (_) => listener.gesture(GestureType.onScaleStart, _),
      onScaleUpdate: (_) => listener.gesture(GestureType.onScaleUpdate, _),
      onTap: () => listener.gesture(GestureType.onTap),
      onTapCancel: () => listener.gesture(GestureType.onTapCancel),
      onTapDown: (_) => listener.gesture(GestureType.onTapDown, _),
      onTapUp: (_) => listener.gesture(GestureType.onTapUp, _),
    );
  }
}
