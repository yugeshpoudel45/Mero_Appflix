import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final videoUrl = "https://youtu.be/hjQGq6uytiQ?si=ViPGYruUaEC0Cr4L";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
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
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        // thumbnail: ,
        aspectRatio: 16 / 9,
        topActions: const [
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              // _controller.metadata.title,
              "Lamba ji madam lamba ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          //!Improve this setting button later on
          PlaybackSpeedButton(),
          SizedBox(width: 12.0),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //     size: 25.0,
          //   ),
          //   onPressed: () {
          //     PopupMenuButton(

          //       itemBuilder: (context) {
          //         return <PopupMenuItem>[
          //           // const PopupMenuItem(child: PlaybackSpeedButton()),
          //           const PopupMenuItem(
          //             child: Text('Quality'),
          //           ),
          //         ];
          //       },
          //     );
          //   },
          // ),
        ],
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
            ),
          ),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          FullScreenButton(),
        ],
        controller: _controller,
        onReady: () {
          log('Player is ready.');
        },
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
          ],
        );
      },
    );
  }
}
