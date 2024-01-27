import 'package:flutter/material.dart';

import '../primary_buttons/primary_short_button.dart';
import '../secondary_button/secondary_button.dart';

class BottomSheetButtons extends StatelessWidget {
  const BottomSheetButtons({
    super.key,
    required this.buttonText1,
    required this.buttonText2,
    required this.func1,
    required this.func2,
  });
  final String buttonText1;
  final String buttonText2;
  final VoidCallback func1;
  final VoidCallback func2;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Material(
      color: myColorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
              text: buttonText1,
              func: func1,
            ),
            PrimaryShortButton(
              text: buttonText2,
              func: func2,
            ),
          ],
        ),
      ),
    );
  }
}
