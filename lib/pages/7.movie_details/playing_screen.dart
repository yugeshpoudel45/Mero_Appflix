import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';
import 'package:netflix/models/others/readmore_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/others/movie_listtile_model.dart';
import '../../routes/app_route_constant.dart';

class PlayingPage extends StatefulWidget {
  final String name;
  final String movieKey;
  final bool isMovie;
  final dynamic loadedState;
  const PlayingPage({
    super.key,
    required this.movieKey,
    required this.loadedState,
    required this.name,
    this.isMovie = true,
  });

  @override
  State<PlayingPage> createState() => PlayingPageState();
}

class PlayingPageState extends State<PlayingPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieKey,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        // thumbnail: ,
        aspectRatio: 16 / 9,
        topActions: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              widget.name.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const PlaybackSpeedButton(),
          const SizedBox(width: 12.0),
        ],
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: myColorScheme.onTertiary,
              handleColor: myColorScheme.onTertiary,
            ),
          ),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          FullScreenButton(),
        ],
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            widget.isMovie
                ? widget.loadedState.movieDetailsModel.title!
                : widget.loadedState.tvShowDetailsModel.name!,
            style: myTextTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          )),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            widget.name,
                            style: myTextTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      bottom: 8,
                      right: 16,
                      top: 8,
                    ),
                    child: ReadMoreModel(
                      // text: widget.loadedState.movieDetailsModel.overview!,
                      text: widget.isMovie
                          ? widget.loadedState.movieDetailsModel.overview!
                          : widget.loadedState.tvShowDetailsModel.overview!,
                      textStyle: myTextTheme.bodyMedium!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "More Videos",
                        style: myTextTheme.headlineSmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: List.generate(
                          // widget.loadedState.movieDetailsModel.videos!.results!
                          //     .length,
                          widget.isMovie
                              ? widget.loadedState.movieDetailsModel.videos!
                                  .results!.length
                              : widget.loadedState.tvShowDetailsModel.videos!
                                  .results!.length, (index) {
                        final movieVidoes =
                            // widget.loadedState.movieDetailsModel.videos!;
                            widget.isMovie
                                ? widget.loadedState.movieDetailsModel.videos!
                                : widget.loadedState.tvShowDetailsModel.videos!;
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              MyAppRouteConstants.playingPage,
                              extra: widget.loadedState,
                              pathParameters: {
                                'movieKey': movieVidoes.results![index].key!,
                                'name': movieVidoes.results![index].name!,
                                'isMovie': widget.isMovie ? 'true' : 'false',
                              },
                            );
                          },
                          child: MovieListTileModel(
                            image: widget.isMovie
                                ? widget
                                    .loadedState.movieDetailsModel.backdropPath!
                                : widget.loadedState.tvShowDetailsModel
                                    .backdropPath!,
                            name: movieVidoes.results![index].name!,
                            description:
                                movieVidoes.results![index].size.toString(),
                            date: movieVidoes.results![index].publishedAt!.year
                                .toString(),
                            tag: movieVidoes.results![index].type!,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
