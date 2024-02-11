import 'package:flutter/material.dart';

import '../../../data/movie_carousel_data.dart';
import '../../../models/movie_carousel_model.dart';


class Top10MoviesThisWeekPage extends StatelessWidget {
  const Top10MoviesThisWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top 10 Movies This Week",
          style: myTextTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 8,
          bottom: 8,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              ...movieCarouselData
                  .map(
                    (e) => MovieCarouselModel(
                      width: mySize.width / 2.25,
                      height: mySize.height / 3.2,
                      image: e['image'],
                      rating: e['rating'],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
