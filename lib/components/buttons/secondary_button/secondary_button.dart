import 'package:flutter/material.dart';
import 'package:netflix/components/buttons/main_button_template/app_button.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text, required this.func});

  final String text;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    return AppButton(
      isFilled: false,
      text: text,
      height: mySize.height / 14,
      width: mySize.width / 2.3,
      func: func,
    );
  }
}
