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
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 12,
            ),
            child: SizedBox(
              height: mySize.height / 32,
              width: mySize.width / 8,
              child: TextButton(
                style: TextButton.styleFrom(
                  visualDensity: const VisualDensity(
                    vertical: VisualDensity.minimumDensity,
                    horizontal: VisualDensity.minimumDensity,
                  ),
                  backgroundColor: myColorScheme.onTertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  rating,
                  style: myTextTheme.labelSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
