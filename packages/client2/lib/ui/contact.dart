import 'package:flutter/widgets.dart';

import './common.dart';

class ContactRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Contact"),
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
