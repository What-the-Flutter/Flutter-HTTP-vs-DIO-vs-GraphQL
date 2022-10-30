import 'package:client/presentation/app/theme/base_color_constants.dart';
import 'package:flutter/material.dart';

class NetworkingTextButton extends StatelessWidget {
  final bool isButtonActive;
  final VoidCallback onClick;
  final String buttonText;
  final double textSize;
  final double margin;

  const NetworkingTextButton({
    Key? key,
    required this.isButtonActive,
    required this.onClick,
    required this.buttonText,
    this.textSize = 20,
    this.margin = 25
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            isButtonActive ? BaseColors.buttonColorActive : BaseColors.buttonColorBlocked,
          ),
        ),
        onPressed: () {
          if (isButtonActive) {
            onClick();
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: textSize, color: BaseColors.textColorLight),
        ),
      ),
    );
  }
}
