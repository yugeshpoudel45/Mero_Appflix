import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.isFilled,
    required this.text,
    required this.height,
    required this.width,
    required this.func,
  });

  final bool isFilled;
  final String text;
  final double height;
  final double width;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        type: MaterialType.button,
        elevation: 2,
        shadowColor: myColorScheme.onBackground,
        color: isFilled
            ? myColorScheme.onTertiary
            : myColorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: TextButton(
          onPressed: func,
          child: Text(text,
              style: myTextTheme.labelLarge!.copyWith(
                color: isFilled ? Colors.white : myColorScheme.onSurface,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
