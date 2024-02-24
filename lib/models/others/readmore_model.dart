import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ReadMoreModel extends StatelessWidget {
  final String text;
  const ReadMoreModel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return ReadMoreText(
      text,
      trimLines: 3,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Read more',
      trimExpandedText: '',
      moreStyle: myTextTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      style: myTextTheme.bodyMedium,
    );
  }
}
