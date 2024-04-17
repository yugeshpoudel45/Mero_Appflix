import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'cache_image_manager.dart';

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
    return CachedNetworkImage(
      cacheManager: CustomCacheManager.instance,
      key: UniqueKey(),
      height: height,
      width: width,
      fit: fit,
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
    );
  }
}
