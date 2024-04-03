import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ReadMoreModel extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final int trimLines;
  const ReadMoreModel({super.key, required this.text, required this.textStyle, this.trimLines = 3});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return ReadMoreText(
      text,
      trimLines: trimLines,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read more',
      trimExpandedText: '',
      moreStyle: myTextTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      style: textStyle,
    );
  }
}
