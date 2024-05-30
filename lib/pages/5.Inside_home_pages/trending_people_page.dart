import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';

import '../../cubit/trending_section_cubit.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../routes/app_route_constant.dart';

class TrendingPeoplePage extends StatelessWidget {
  final TrendingSectionLoadedState loadedState;

  const TrendingPeoplePage({super.key, required this.loadedState});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Celebrities",
          style: myTextTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
           if (state == NetworkState.disconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'PLEASE CONNECT TO THE INTERNET',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                backgroundColor: Colors.red[400],
                duration: const Duration(days: 1),
                behavior: SnackBarBehavior.fixed,
                dismissDirection: DismissDirection.none,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
            right: 8,
            bottom: 8,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              children: List.generate(10, (int movieIndex) {
                var movie =
                    loadedState.trendingPeopleModel.results![movieIndex];
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      MyAppRouteConstants.peopleDetailsPage,
                      extra: movie.id,
                    );
                  },
                  child: MovieCarouselModel(
                    isPeople: true,
                    width: mySize.width / 2.25,
                    height: mySize.height / 3.2,
                    image: movie.profilePath.toString(),
                    rating: movie.popularity!,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
