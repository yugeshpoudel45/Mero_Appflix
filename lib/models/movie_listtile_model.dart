import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/buttons/other_buttons/info_button.dart';

class MovieListTileModel extends StatelessWidget {
  const MovieListTileModel({
    super.key,
    required this.image,
    required this.movieName,
    required this.episodes,
    required this.date,
    required this.tag,
  });

  final String image;
  final String movieName;
  final String episodes;
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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: mySize.width / 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: mySize.width / 3.5,
                child: Text(
                  movieName,
                  style: myTextTheme.titleLarge!.copyWith(
                    fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                "$episodes Episodes",
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
