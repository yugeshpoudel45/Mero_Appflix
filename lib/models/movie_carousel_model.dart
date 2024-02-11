import 'package:flutter/material.dart';

class MovieCarouselModel extends StatelessWidget {
  const MovieCarouselModel({
    super.key,
    required this.image,
    required this.rating,
    this.height = 200,
    this.width = 144,
  });

  final String image;
  final String rating;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          image: DecorationImage(
            image: NetworkImage("https://image.tmdb.org/t/p/original/$image"),
            fit: BoxFit.cover,
            // opacity: 0.9,
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 8,
            ),
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
                    rating.substring(0, 3),
                    style: myTextTheme.labelSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
