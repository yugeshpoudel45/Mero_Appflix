import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:netflix/components/images/cache_image_manager.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  static final customCacheManager = CacheManager(
    Config(
      "customCacheKey",
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 100,
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              cacheManager: CustomCacheManager.instance,
              key: UniqueKey(),
              height: 400,
              width: double.maxFinite,
              imageUrl:
                  "https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    // colorFilter:
                    //     const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // Image.network(
            //     "https://en.wikipedia.org/wiki/Facebook#/media/File:Facebook_logo_(2023).svg"),

            // Text("Hello World"),
          ],
        ),
      ),
    );
  }
}
