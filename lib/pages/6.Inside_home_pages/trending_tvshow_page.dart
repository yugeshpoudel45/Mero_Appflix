import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/blocs/cubit/trending_section_cubit.dart';

import '../../models/movie_carousel_model.dart';

class TrendingTvShowsPage extends StatefulWidget {
  const TrendingTvShowsPage({super.key});

  @override
  State<TrendingTvShowsPage> createState() => _TrendingTvShowsPageState();
}

class _TrendingTvShowsPageState extends State<TrendingTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TrendingSectionCubit>().onFetchingTrendingSection();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Movies Today",
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
      body: BlocBuilder<TrendingSectionCubit, TrendingSectionState>(
          builder: (context, state) {
        if (state is TrendingSectionLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrendingSectionErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is TrendingSectionLoadedState) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 8,
              bottom: 8,
            ),
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  for (var movie in state.trendingMovieModel.results!)
                    MovieCarouselModel(
                      width: mySize.width / 2.25,
                      height: mySize.height / 3.2,
                      image: movie.posterPath.toString(),
                      rating: movie.popularity!,
                    ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
