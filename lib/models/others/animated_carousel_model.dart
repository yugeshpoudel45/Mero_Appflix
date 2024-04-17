import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/images/cache_image_manager.dart';

class AnimatedCarouselModel extends StatefulWidget {
  final List<String> items;
  final double height;
  const AnimatedCarouselModel({
    Key? key,
    required this.items,
    this.height = 200,
  }) : super(key: key);

  @override
  State<AnimatedCarouselModel> createState() => _AnimatedCarouselModelState();
}

class _AnimatedCarouselModelState extends State<AnimatedCarouselModel> {
  int currentPage = 0;
  final controller = CarouselController();

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
            CachedNetworkImage(
              cacheManager: CustomCacheManager.instance,
              key: UniqueKey(),
              height: widget.height,
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
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
