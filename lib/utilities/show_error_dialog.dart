//Now we have to create a dialog and show all the possible errors that can happen during the time of login.

import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("An error occurred"),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); //Helps to get rid of the dialog box, on pressing the "OK".
              },
              child: const Text("OK")),
        ],
      );
    },
  );
}
