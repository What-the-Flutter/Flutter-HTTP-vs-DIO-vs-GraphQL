import 'package:flutter/material.dart';

AlertDialog errorDialog({
  required BuildContext context,
  required String errorTitle,
  required String errorMessage,
}) {
  return AlertDialog(
    title: Text(errorTitle),
    content: Text(errorMessage),
    actions: <Widget>[
      TextButton(
        child: const Text('Approve'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
