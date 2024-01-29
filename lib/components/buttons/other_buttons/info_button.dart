import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.text,
    required this.func,
  });

  final String text;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return TextButton(
      style: TextButton.styleFrom(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        backgroundColor: myColorScheme.onInverseSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: func,
      child: Text(
        text,
        style: myTextTheme.labelSmall!.copyWith(
          color: myColorScheme.onTertiary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
