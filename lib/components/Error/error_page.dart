import 'package:flutter/material.dart';

class ShowErrorMessage extends StatelessWidget {
  const ShowErrorMessage({
    this.errorMessage = "No Results Found!!",
    this.extraInfo =
        "Sorry, the keyword you entered could not be found. Please try again with a different keyword.",
    super.key,
  });
  final String errorMessage;
  final String extraInfo;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          height: mySize.height / 3,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              errorMessage,
              style: myTextTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: myColorScheme.onTertiary,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            extraInfo,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
