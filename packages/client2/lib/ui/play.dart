import 'package:flutter/widgets.dart';

import './common.dart';

class PlayRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Play"),
        Button(
          label: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
