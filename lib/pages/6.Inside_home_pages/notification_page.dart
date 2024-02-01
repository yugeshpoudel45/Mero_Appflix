import 'package:flutter/material.dart';
import 'package:netflix/data/movie_listtile_data.dart';

import '../../models/movie_listtile_model.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: myTextTheme.headlineSmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.pending_outlined,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...movieListtileData
                  .map(
                    (e) => MovieListTileModel(
                      image: e['image'],
                      movieName: e['movieName'],
                      episodes: e['episodes'],
                      date: e['date'],
                      tag: e['tag'],
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
