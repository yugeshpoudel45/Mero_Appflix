import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
    required this.height,
    required this.width,
    this.isCircle = false,
  }) : super(key: key);

  final double height, width;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Container(
      height: height,
      width: width,
      decoration: isCircle
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: myColorScheme.primaryContainer,
            )
          : BoxDecoration(
              color: myColorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
    );
  }
}

// Color: Colors.grey[300] (Light Grey)
// Color: #E0E0E0 (Light Grey)

// Color: #757575 (Dark Grey)
