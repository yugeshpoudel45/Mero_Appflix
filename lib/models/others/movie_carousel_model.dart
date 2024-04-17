import 'package:flutter/material.dart';
import 'package:netflix/components/images/cache_network_image.dart';

class MovieCarouselModel extends StatelessWidget {
  const MovieCarouselModel({
    super.key,
    required this.image,
    required this.rating,
    this.height = 200,
    this.width = 144,
  });

  final String image;
  final double rating;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          AppNetworkImage(
            image: image,
            height: height,
            width: width,
            borderRadius: BorderRadius.circular(4),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Opacity(
              opacity: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: myColorScheme.onTertiary,
                ),
                height: mySize.height / 32,
                width: mySize.width / 12,
                child: Center(
                  child: Text(
                    rating.toString().substring(0, 3),
                    style: myTextTheme.labelSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
