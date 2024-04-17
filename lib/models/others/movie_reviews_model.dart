import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/models/others/readmore_model.dart';

import '../../components/images/cache_image_manager.dart';

class MovieReviewsModel extends StatefulWidget {
  final String name;
  final String userName;
  final String comment;
  final double rating;
  final DateTime datetime;
  final String avatar;
  const MovieReviewsModel(
      {super.key,
      required this.name,
      required this.userName,
      required this.comment,
      required this.rating,
      required this.datetime,
      required this.avatar});

  @override
  State<MovieReviewsModel> createState() => _MovieReviewsModelState();
}

class _MovieReviewsModelState extends State<MovieReviewsModel> {
  bool liked = true;
  int likeCounter = 45;
  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              "https://image.tmdb.org/t/p/original/${widget.avatar}",
              cacheManager: CustomCacheManager.instance,
              errorListener: (p0) => log(
                "Error: $p0",
                name: "CachedNetworkImage",
              ),
            ),
          ),
          title: Text(
            widget.name,
            style: myTextTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '@${widget.userName}',
            style: myTextTheme.labelLarge!.copyWith(
              fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
            ),
          ),
          trailing: Column(
            children: [
              Icon(
                Icons.star_half_rounded,
                color: myColorScheme.onTertiary,
              ),
              Text('${widget.rating}/10'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ReadMoreModel(
            text: widget.comment,
            textStyle: myTextTheme.bodyMedium!,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 12,
            right: 16,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    liked = !liked;
                    if (liked == false) {
                      likeCounter++;
                    } else {
                      likeCounter--;
                    }
                  });
                },
                child: Container(
                    child: liked
                        ? const Icon(
                            CupertinoIcons.heart,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "$likeCounter",
                style: myTextTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 64,
              ),
              Text(
                "${widget.datetime.year}-${widget.datetime.month}-${widget.datetime.day}",
                style: myTextTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
      ],
    );
  }
}
