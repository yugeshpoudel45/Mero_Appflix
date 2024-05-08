import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckRating extends StatelessWidget {
  final double rating;
  const CheckRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return rating >= 8.0
        ? Icon(
            CupertinoIcons.star_fill,
            color: myColorScheme.onTertiary,
          )
        : rating >= 5.0
            ? Icon(
                CupertinoIcons.star_lefthalf_fill,
                color: myColorScheme.onTertiary,
              )
            : Icon(
                CupertinoIcons.star,
                color: myColorScheme.onTertiary,
              );
  }
}
