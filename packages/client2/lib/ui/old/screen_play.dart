// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../game/game.dart';
// import '../ui/gesture_widget.dart';
// import '../ui/render_widget.dart';

// class Play extends StatelessWidget {
//   Widget build(BuildContext context) {
//     final game = Game();

//     return Stack(children: [
//       GestureWidget(
//         child: Container(
//           child: RenderWidget(game),
//           color: Color(0xFF222222),
//           constraints: BoxConstraints.expand(),
//         ),
//         listener: game,
//       ),
//       RaisedButton(
//         child: Text("home"),
//         onPressed: () {
//           Navigator.popAndPushNamed(context, '/');
//         },
//       )
//     ]);
//   }
// }
