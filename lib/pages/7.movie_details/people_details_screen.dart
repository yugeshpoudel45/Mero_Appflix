import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/models/others/animated_carousel_model.dart';
import 'package:netflix/routes/app_route_constant.dart';

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PeopleDetailsErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is PeopleDetailsLoadedState) {
          final people = state.peopleDetailsModel;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  people.images!.profiles!.isNotEmpty
                      ? AnimatedCarouselModel(
                          height: mySize.height / 1.8,
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
                            people.deathday != null
                                ? _MyListTile(
                                    title: "Born",
                                    details:
                                        "${people.birthday!.year}-${people.birthday!.month}-${people.birthday!.day}",
                                  )
                                : const SizedBox(),
                            _MyListTile(
                                title: "BirthPlace",
                                details: people.placeOfBirth.toString()),
                            people.deathday != null
                                ? _MyListTile(
                                    title: "Died",
                                    details:
                                        "${people.deathday!.year}-${people.deathday!.month}-${people.deathday!.day}")
                                : const SizedBox(),
                            _MyListTile(
                              title: "Gender",
                              details: people.gender == 1 ? "Female" : "Male",
                            ),
                            _MyListTile(
                              title: "Department",
                              details: people.knownForDepartment.toString(),
                            ),
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
                        Text(
                          'Known For',
                          style: myTextTheme.titleLarge!.copyWith(
                            fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                          ),
                        ),
                        SizedBox(height: mySize.height / 80),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: people
                                        .combinedCredits!.cast!.isNotEmpty
                                    ? (people.combinedCredits!.cast!.length > 5
                                        ? 5
                                        : people.combinedCredits!.cast!.length)
                                    : (people.combinedCredits!.crew!.length > 5
                                        ? 5
                                        : people.combinedCredits!.crew!.length),
                                itemBuilder: (context, index) {
                                  var movie = people
                                          .combinedCredits!.cast!.isNotEmpty
                                      ? people.combinedCredits!.cast![index]
                                      : people.combinedCredits!.crew![index];

                                  return GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).pushNamed(
                                        MyAppRouteConstants.movieDetailsPage,
                                        extra: movie.id,
                                      );
                                    },
                                    child: MovieCarouselModel(
                                      image: movie.posterPath.toString(),
                                      rating: movie.popularity!,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     IconButton(
                        //       icon: const Icon(Icons.facebook),
                        //       onPressed: () {
                        //         // Handle Facebook link
                        //       },
                        //     ),
                        //     IconButton(
                        //       icon: const Icon(Icons.one_x_mobiledata),
                        //       onPressed: () {
                        //         // Handle Twitter link
                        //       },
                        //     ),
                        //     IconButton(
                        //       icon: const Icon(Icons.perm_identity_rounded),
                        //       onPressed: () {
                        //         // Handle Instagram link
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
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
      ),
      trailing: Text(
        details,
        style: myTextTheme.titleSmall,
      ),
    );
  }
}
