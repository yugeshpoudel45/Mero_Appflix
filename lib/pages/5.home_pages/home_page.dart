import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/config/app_local_assets.dart';

import '../../blocs/cubit/home_page_cubit.dart';
import '../../components/buttons/play_button/play_button.dart';
import '../../models/movie_carousel_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().onFetchingTrendingSection();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<HomePageCubit, HomePageState>(builder: (context, state) {
      if (state is HomePageLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HomePageErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is HomePageLoadedState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              TopCarousel(mySize: mySize, myTextTheme: myTextTheme),
              TrendingMovie(myTextTheme, myColorScheme, mySize, state),
              // TrendingPeople(myTextTheme, myColorScheme, mySize, state),
              // TrendingTvShow(myTextTheme, myColorScheme, mySize, state),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

//   Padding TrendingTvShow(TextTheme myTextTheme, ColorScheme myColorScheme,
//       Size mySize, HomePageLoadedState state) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Top 5 Tv Shows This Week",
//                 style: myTextTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
//                 ),
//               ),
//               Text(
//                 "See all",
//                 style: myTextTheme.titleSmall!.copyWith(
//                   color: myColorScheme.onTertiary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: mySize.height / 64),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(
//               height: 200,
//               child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return MovieCarouselModel(
//                       image: state
//                           .trendingTvShowModel.results![index].posterPath
//                           .toString(),
//                       rating: state
//                           .trendingTvShowModel.results![index].voteAverage
//                           .toString(),
//                     );
//                   }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Padding TrendingPeople(TextTheme myTextTheme, ColorScheme myColorScheme,
//       Size mySize, HomePageLoadedState state) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 16,
//         right: 16,
//         bottom: 16,
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Top 5 Celebrities This Week",
//                 style: myTextTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
//                 ),
//               ),
//               Text(
//                 "See all",
//                 style: myTextTheme.titleSmall!.copyWith(
//                   color: myColorScheme.onTertiary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: mySize.height / 64),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(
//               height: 200,
//               child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return MovieCarouselModel(
//                       image: state
//                           .trendingPeopleModel.results![index].profilePath
//                           .toString(),
//                       rating: state
//                           .trendingPeopleModel.results![index].popularity
//                           .toString(),
//                     );
//                   }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  Padding TrendingMovie(TextTheme myTextTheme, ColorScheme myColorScheme,
      Size mySize, HomePageLoadedState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top 5 Movies This Week",
                style: myTextTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                ),
              ),
              Text(
                "See all",
                style: myTextTheme.titleSmall!.copyWith(
                  color: myColorScheme.onTertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: mySize.height / 64),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return MovieCarouselModel(
                      image: state.trendingMovieModel.results![index].posterPath
                          .toString(),
                      rating: state
                          .trendingMovieModel.results![index].voteAverage
                          .toString(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class TopCarousel extends StatelessWidget {
  const TopCarousel({
    super.key,
    required this.mySize,
    required this.myTextTheme,
  });

  final Size mySize;
  final TextTheme myTextTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mySize.height / 2.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.onBoard1),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mySize.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: mySize.height / 24,
                ),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: mySize.width / 20),
                    const Icon(
                      CupertinoIcons.bell,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              "Fast & Furious",
              style: myTextTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Action. Superhero. Science. Fiction.",
              style: myTextTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: mySize.height / 80),
            Row(
              children: [
                PlayButton(
                  icon: Icons.play_circle_fill_rounded,
                  text: "Play",
                  func: () {},
                ),
                SizedBox(width: mySize.width / 24),
                PlayButton(
                  isFilled: false,
                  width: 104,
                  icon: Icons.add,
                  text: "My List",
                  func: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
