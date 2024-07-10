import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/components/shimmers/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';
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
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
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
          Shimmer.fromColors(
        baseColor: myColorScheme.primaryContainer,
        highlightColor: myColorScheme.background,
        child: ShimmerWidget(
          height: height,
          width: width,
        ),
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
