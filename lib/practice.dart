// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class Practice extends StatefulWidget {
//   const Practice({super.key});

//   @override
//   State<Practice> createState() => _PracticeState();
// }

// class _PracticeState extends State<Practice> {
//   final videoUrl = "https://youtu.be/hjQGq6uytiQ?si=ViPGYruUaEC0Cr4L";

//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
//       flags: const YoutubePlayerFlags(
//         enableCaption: false,
//         controlsVisibleAtStart: true,
//         forceHD: true,
//       ),
//     );
//   }

//   @override
//   void deactivate() {
//     super.deactivate();
//     _controller.pause();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: YoutubePlayerBuilder(
//         onExitFullScreen: () {
//           // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
//           SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//         },
//         player: YoutubePlayer(
//           // thumbnail: ,
//           aspectRatio: 16 / 9,
//           topActions: const [
//             SizedBox(width: 8.0),
//             Expanded(
//               child: Text(
//                 // _controller.metadata.title,
//                 "Lamba ji madam lamba ",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18.0,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//             //!Improve this setting button later on
//             PlaybackSpeedButton(),
//             SizedBox(width: 12.0),
//           ],
//           bottomActions: [
//             CurrentPosition(),
//             const SizedBox(width: 10.0),
//             ProgressBar(
//               isExpanded: true,
//               colors: const ProgressBarColors(
//                 playedColor: Colors.red,
//                 handleColor: Colors.red,
//               ),
//             ),
//             const SizedBox(width: 10.0),
//             RemainingDuration(),
//             FullScreenButton(),
//           ],
//           controller: _controller,
//           onReady: () {
//             log('Player is ready.');
//           },
//         ),
//         builder: (context, player) {
//           return Column(
//             children: [
//               player,
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

//!-------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:netflix/config/app_local_assets.dart';

// import 'components/buttons/other_buttons/info_button.dart';

// class Practice extends StatelessWidget {
//   const Practice({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size mySize = MediaQuery.sizeOf(context);
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//             top: 8,
//             bottom: 8,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: mySize.height / 8,
//                 width: mySize.width / 3,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(8),
//                   ),
//                   image: DecorationImage(
//                     image: AssetImage(AppAssets.onBoard1),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: mySize.width / 24),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Trailer 3: Infinity War",
//                     style: myTextTheme.titleMedium!.copyWith(
//                       fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                   Text(
//                     "1m 45s",
//                     style: myTextTheme.bodySmall,
//                   ),
//                   InfoButton(
//                     text: "Update",
//                     func: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:netflix/config/app_local_assets.dart';
import 'package:netflix/models/others/movie_listtile_model.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice"),
      ),
      body: const Column(
        children: [
          MovieListTileModel(
            image: AppAssets.onBoard1,
            name: "Trailer 1",
            description: "1",
            date: "2016",
            tag: "Update",
          ),
        ],
      ),
    );
  }
}
