import 'package:flutter/material.dart';

class DirectLoginButton extends StatelessWidget {
  final String logo;
  final VoidCallback func;
  final String text;
  final bool haveText;
  const DirectLoginButton({
    super.key,
    required this.func,
    required this.logo,
    required this.haveText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: mySize.height / 14,
      // width: haveText ? mySize.width : mySize.width / 6,
      child: OutlinedButton(
        onPressed: func,
        style: OutlinedButton.styleFrom(
          backgroundColor: myColorScheme.onInverseSurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          side: BorderSide(
            width: 0.1,
            color: myColorScheme.inverseSurface,
          ),
        ),
        child: haveText
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    height: 32,
                    width: 32,
                  ),
                  SizedBox(
                    width: mySize.width / 32,
                  ),
                  Text(
                    "Continue with $text",
                    style: myTextTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Image.asset(
                logo,
                height: 24,
              ),
      ),
    );
  }
}
