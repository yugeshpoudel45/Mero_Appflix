import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/buttons/other_buttons/info_button.dart';
import '../../components/images/cache_image_manager.dart';

class MovieListTileModel extends StatelessWidget {
  const MovieListTileModel({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.date,
    required this.tag,
  });

  final String image;
  final String name;
  final String description;
  final String date;
  final String tag;

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mySize.height / 8,
            width: mySize.width / 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                image:
                    // NetworkImage("https://image.tmdb.org/t/p/original/$image"),
                    CachedNetworkImageProvider(
                  "https://image.tmdb.org/t/p/original/$image",
                  cacheManager: CustomCacheManager.instance,
                  errorListener: (p0) => log(
                    "Error: $p0",
                    name: "CachedNetworkImage",
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white,
            ),
          ),
          SizedBox(width: mySize.width / 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: mySize.width / 3.5,
                child: Text(
                  name,
                  style: myTextTheme.titleMedium!.copyWith(
                    fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                description,
                style: myTextTheme.bodySmall,
              ),
              InfoButton(
                text: tag,
                func: () {},
              ),
            ],
          ),
          SizedBox(width: mySize.width / 24),
          Text(
            date,
            style: myTextTheme.labelMedium!.copyWith(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
