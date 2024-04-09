import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  const AppNetworkImage({
    Key? key,
    required this.image,
    this.width = 40,
    this.height = 80,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
