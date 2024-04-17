import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'cache_image_manager.dart';

class AppNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  const AppNetworkImage({
    Key? key,
    required this.image,
    this.width = 40,
    this.height = 80,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager.instance,
      key: UniqueKey(),
      height: height,
      width: width,
      imageUrl: "https://image.tmdb.org/t/p/original/$image",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) {
        log("Error loading image: $error");
        return const Center(
          child: Icon(Icons.error),
        );
      },
    );
  }
}
