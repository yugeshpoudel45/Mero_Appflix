
import 'package:flutter/material.dart';

class ChoosingItemButton extends StatefulWidget {
  const ChoosingItemButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<ChoosingItemButton> createState() => _ChoosingItemButtonState();
}

class _ChoosingItemButtonState extends State<ChoosingItemButton> {
  bool isFilled = false;

  void _buttonPressed() {
    setState(() {
      isFilled = !isFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isFilled ? myColorScheme.onTertiary : myColorScheme.surface,
          side: isFilled
              ? const BorderSide(style: BorderStyle.none)
              : BorderSide(
                  style: BorderStyle.solid,
                  width: 1.2,
                  color: myColorScheme.onTertiary,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: _buttonPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(widget.text,
              style: myTextTheme.labelLarge!.copyWith(
                color: isFilled ? Colors.white : myColorScheme.onTertiary,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
