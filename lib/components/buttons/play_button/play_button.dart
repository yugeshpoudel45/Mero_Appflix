import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.icon,
    required this.text,
    required this.func,
    this.height = 36,
    this.width = 80,
    this.isFilled = true,
    this.isDownloadButton = false,
  });

  final bool isFilled;
  final IconData icon;
  final String text;
  final double height;
  final double width;
  final VoidCallback func;
  final bool isDownloadButton;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              isFilled ? myColorScheme.onTertiary : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          side: BorderSide(
            color: isFilled
                ? Colors.transparent
                : isDownloadButton
                    ? myColorScheme.onTertiary
                    : Colors.white,
            width: 2,
          ),
        ),
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDownloadButton ? myColorScheme.onTertiary : Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(text,
                style: myTextTheme.labelLarge!.copyWith(
                  color: isDownloadButton
                      ? myColorScheme.onTertiary
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
