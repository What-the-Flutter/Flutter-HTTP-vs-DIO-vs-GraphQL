import 'package:client/presentation/app/localization/app_localization_constants.dart';
import 'package:flutter/material.dart';

void showInfoDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onButtonClick,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onButtonClick,
          child: Text(
            AppStrings.approve(context),
          ),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
