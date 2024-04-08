import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AnimatedCarouselModel extends StatefulWidget {
  final List<String> items;
  const AnimatedCarouselModel({
    super.key,
    required this.items,
  });

  @override
  State<AnimatedCarouselModel> createState() => _AnimatedCarouselModelState();
}

class _AnimatedCarouselModelState extends State<AnimatedCarouselModel> {
  int currentPage = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        String image = widget.items[index];
        return Stack(alignment: Alignment.bottomCenter, children: [
          Image.network(
            "https://image.tmdb.org/t/p/original/$image",
            fit: BoxFit.cover,
            width: mySize.width,
            height: mySize.height / 2.5,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.items.length,
                (index) => buildDot(index, context),
              ),
            ),
          )
        ]);
      },
      options: CarouselOptions(
        height: mySize.height / 2.5,
        autoPlay: true,
        viewportFraction: 1,
        onPageChanged: (i, reason) {
          setState(
            () {
              currentPage = i;
            },
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 8.0,
      width: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentPage == index ? myColorScheme.onTertiary : Colors.white,
      ),
    );
  }
}
