import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key, required this.checkBox, required this.func});

  final bool checkBox;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Checkbox(
      side: BorderSide(color: myColorScheme.onTertiary, width: 2),
      checkColor: Colors.white,
      activeColor: myColorScheme.onTertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      value: checkBox,
      onChanged: (value) => func(),
    );
  }
}
