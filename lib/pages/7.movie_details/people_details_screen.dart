import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';
import 'package:netflix/models/others/animated_carousel_model.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../../components/Error/error_page.dart';
import '../../components/urls/url_launcher.dart';
import '../../config/app_constants.dart';
import '../../cubit/people_details_cubit.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../models/others/readmore_model.dart';

class PeopleDetailsScreen extends StatefulWidget {
  final int peopleId;
  const PeopleDetailsScreen({
    super.key,
    required this.peopleId,
  });

  @override
  State<PeopleDetailsScreen> createState() => _PeopleDetailsScreenState();
}

class _PeopleDetailsScreenState extends State<PeopleDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PeopleDetailsCubit>().onFetchingPeopleDetails(
          widget.peopleId,
        );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<PeopleDetailsCubit, PeopleDetailsState>(
      builder: (context, state) {
        if (state is PeopleDetailsLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PeopleDetailsErrorState) {
          return Scaffold(
            body: ShowErrorMessage(
              errorMessage: state.errorMessage,
              extraInfo: "😞",
            ),
          );
        } else if (state is PeopleDetailsLoadedState) {
          final people = state.peopleDetailsModel;
          var movie1 = people.combinedCredits!.cast!
              .where((element) =>
                  element.posterPath != AppConstants.placeHolderImage)
              .toList();
          var movie2 = people.combinedCredits!.cast!
              .where((element) =>
                  element.posterPath != AppConstants.placeHolderImage)
              .toList();
          var combinedMovie = movie1 + movie2;

          String facebookId = people.externalIds!.facebookId.toString();
          String instagramId = people.externalIds!.instagramId.toString();
          String tiktokId = people.externalIds!.tiktokId.toString();
          String twitterId = people.externalIds!.twitterId.toString();
          String youtubeId = people.externalIds!.youtubeId.toString();

          return Scaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    people.images!.profiles!.isNotEmpty
                        ? AnimatedCarouselModel(
                            height: mySize.height / 1.6,
                            items: people.images!.profiles!
                                .map((e) => e.filePath!)
                                .toList())
                        : SizedBox(
                            height: mySize.height / 40,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mySize.width,
                            child: Text(
                              people.name!,
                              style: myTextTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          people.alsoKnownAs!.isNotEmpty
                              ? SizedBox(
                                  width: mySize.width,
                                  child: Text(
                                    "(${people.alsoKnownAs![0]})",
                                    style: myTextTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: mySize.height / 64),
                          CupertinoListSection.insetGrouped(
                            header: Text(
                              'Personal Info',
                              style: myTextTheme.titleLarge!.copyWith(
                                fontFamily:
                                    GoogleFonts.balsamiqSans().fontFamily!,
                              ),
                            ),
                            margin: const EdgeInsets.all(4),
                            children: [
                              people.birthday != null
                                  ? _MyListTile(
                                      title: "Born",
                                      details:
                                          "${people.birthday!.year}-${people.birthday!.month}-${people.birthday!.day}",
                                    )
                                  : const SizedBox(),
                              people.placeOfBirth != null &&
                                      people.placeOfBirth!.length < 30
                                  ? _MyListTile(
                                      title: "BirthPlace",
                                      details: people.placeOfBirth.toString())
                                  : const SizedBox(),
                              people.deathday != null
                                  ? _MyListTile(
                                      title: "Died",
                                      details:
                                          "${people.deathday!.year}-${people.deathday!.month}-${people.deathday!.day}")
                                  : const SizedBox(),
                              people.gender != null
                                  ? _MyListTile(
                                      title: "Gender",
                                      details: people.gender == 1
                                          ? "Female"
                                          : "Male",
                                    )
                                  : const SizedBox(),
                              people.knownForDepartment != null
                                  ? _MyListTile(
                                      title: "Department",
                                      details:
                                          people.knownForDepartment.toString(),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(height: mySize.height / 40),
                          people.biography!.isNotEmpty
                              ? Text(
                                  'Biography',
                                  style: myTextTheme.titleLarge!.copyWith(
                                    fontFamily:
                                        GoogleFonts.balsamiqSans().fontFamily!,
                                  ),
                                )
                              : const SizedBox(),
                          people.biography!.isNotEmpty
                              ? ReadMoreModel(
                                  text: people.biography.toString(),
                                  textStyle: myTextTheme.bodyMedium!,
                                )
                              : const SizedBox(),
                          SizedBox(height: mySize.height / 40),
                          facebookId != "unavailable" ||
                                  instagramId != "unavailable" ||
                                  twitterId != "unavailable" ||
                                  tiktokId != "unavailable" ||
                                  youtubeId != "unavailable"
                              ? Text(
                                  'Social Media Handles',
                                  style: myTextTheme.titleLarge!.copyWith(
                                    fontFamily:
                                        GoogleFonts.balsamiqSans().fontFamily!,
                                  ),
                                )
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              facebookId != "unavailable"
                                  ? SocialHandles(
                                      id: facebookId,
                                      socialMedia: "facebook",
                                    )
                                  : const SizedBox(),
                              instagramId != "unavailable"
                                  ? SocialHandles(
                                      id: instagramId,
                                      socialMedia: "instagram",
                                    )
                                  : const SizedBox(),
                              twitterId != "unavailable"
                                  ? SocialHandles(
                                      id: twitterId,
                                      socialMedia: "twitter",
                                    )
                                  : const SizedBox(),
                              tiktokId != "unavailable"
                                  ? SocialHandles(
                                      id: tiktokId,
                                      socialMedia: "tiktok",
                                    )
                                  : const SizedBox(),
                              youtubeId != "unavailable"
                                  ? SocialHandles(
                                      id: youtubeId,
                                      socialMedia: "youtube",
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(height: mySize.height / 40),
                          combinedMovie.isNotEmpty
                              ? Text(
                                  'Known For',
                                  style: myTextTheme.titleLarge!.copyWith(
                                    fontFamily:
                                        GoogleFonts.balsamiqSans().fontFamily!,
                                  ),
                                )
                              : const SizedBox(),
                          combinedMovie.isNotEmpty
                              ? SizedBox(height: mySize.height / 80)
                              : const SizedBox(),
                          combinedMovie.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: combinedMovie.length > 5
                                            ? 5
                                            : combinedMovie.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              combinedMovie[index]
                                                          .mediaType
                                                          .toString() ==
                                                      "MediaType.MOVIE"
                                                  ? GoRouter.of(context)
                                                      .pushNamed(
                                                      MyAppRouteConstants
                                                          .movieDetailsPage,
                                                      extra:
                                                          combinedMovie[index]
                                                              .id,
                                                    )
                                                  : GoRouter.of(context)
                                                      .pushNamed(
                                                      MyAppRouteConstants
                                                          .tvShowDetailsPage,
                                                      extra:
                                                          combinedMovie[index]
                                                              .id,
                                                    );
                                            },
                                            child: MovieCarouselModel(
                                              image: combinedMovie[index]
                                                  .posterPath
                                                  .toString(),
                                              rating: combinedMovie[index]
                                                  .voteAverage!
                                                  .toDouble(),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _MyListTile extends StatelessWidget {
  final String title;
  final String details;
  const _MyListTile({required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return CupertinoListTile.notched(
      title: Text(
        title,
        style: myTextTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
      ),
      trailing: Text(
        details,
        style: myTextTheme.titleSmall,
      ),
    );
  }
}

class SocialHandles extends StatelessWidget {
  const SocialHandles({super.key, required this.id, required this.socialMedia});
  final String id;
  final String socialMedia;

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        launchURL("https://www.$socialMedia.com/$id");
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          "assets/images/$socialMedia.png",
          height: mySize.height / 20,
        ),
      ),
    );
  }
}
