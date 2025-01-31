import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/components/images/cache_network_image.dart';

class AnimatedCarouselModel extends StatefulWidget {
  final List<String> items;
  final double height;
  const AnimatedCarouselModel({
    super.key,
    required this.items,
    this.height = 200,
  });

  @override
  State<AnimatedCarouselModel> createState() => _AnimatedCarouselModelState();
}

class _AnimatedCarouselModelState extends State<AnimatedCarouselModel> {
  int currentPage = 0;
  final controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        String image = widget.items[index];
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AppNetworkImage(
              image: image,
              height: widget.height,
              width: double.maxFinite,
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
          ],
        );
      },
      options: CarouselOptions(
        height: widget.height,
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
