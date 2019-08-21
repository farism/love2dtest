import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import './common.dart';
import '../state/app.dart';

class PlayRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final views = [Button(
            label: 'Strategy',
            onPressed: () {
              appState.ui.setPlayView(PlayView.strategy);
            },
            color: appState.ui.playView == PlayView.strategy
                ? Colors.green
                : Colors.black,
          ),
          Button(
            label: 'Timed',
            onPressed: () {
              appState.ui.setPlayView(PlayView.timed);
            },
            color: appState.ui.playView == PlayView.timed
                ? Colors.green
                : Colors.black,
          )];

    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Play"),
          appState.ui.playView == null ? ,
          Button(
            label: 'Back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}

// import 'package:flutter/widgets.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:provider/provider.dart';

// import './common.dart';
// import '../state/app.dart';

// class PlayItem extends StatelessWidget {
//   PlayItem(this.text);

//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: Center(
//         child: Text(text),
//       ),
//     );
//   }
// }

// class PlayRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);

//     return Observer(builder: (_) {
//       final plays =
//           appState.user.plays.where((play) => play.hero == appState.user.hero);

//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 // height: 400,
//                 ListWheelScrollView(
//                   onSelectedItemChanged: (i) {
//                     print(i);
//                   },
//                   physics: FixedExtentScrollPhysics(),
//                   children: plays.map((play) => PlayItem(play.name)).toList(),
//                   itemExtent: 50,
//                 ),
//                 IgnorePointer(
//                   child: Center(
//                     child: Container(
//                       height: 50,
//                       color: Color.fromRGBO(255, 255, 255, 0.5),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Button(
//             label: 'Next',
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           Button(
//             label: 'Back',
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     });
//   }
// }
