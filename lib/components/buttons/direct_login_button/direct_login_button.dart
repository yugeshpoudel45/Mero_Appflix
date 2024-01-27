import 'package:flutter/material.dart';

class DirectLoginButton extends StatelessWidget {
  final String logo;
  final VoidCallback func;
  final String text;
  final bool haveText;
  final bool isImage;
  final IconData myicon;
  final Color iconColor;
  const DirectLoginButton({
    super.key,
    required this.func,
    this.myicon = Icons.no_accounts,
    this.haveText = false,
    this.logo = "",
    this.isImage = false,
    this.text = "",
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: mySize.height / 14,
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
                  isImage
                      ? Image.asset(
                          logo,
                          height: mySize.height / 20,
                          width: mySize.width / 12,
                        )
                      : Icon(
                          myicon,
                          color: iconColor,
                          size: mySize.height / 20,
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
            : isImage
                ? Image.asset(
                    logo,
                    height: mySize.height / 24,
                    width: mySize.width / 12,
                  )
                : Icon(
                    myicon,
                    color: iconColor,
                    size: mySize.height / 20,
                  ),
      ),
    );
  }
}
