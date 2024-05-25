// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:netflix/components/local_storage/watchlater_helper.dart';
// import 'package:netflix/routes/app_route_constant.dart';

// class DemoStartingPage extends StatefulWidget {
//   const DemoStartingPage({super.key});

//   @override
//   State<DemoStartingPage> createState() => _DemoStartingPageState();
// }

// class _DemoStartingPageState extends State<DemoStartingPage> {
//   // @override
//   // void initState() {
//   //   MyListHelper.clearMovieList();
//   //   MyListHelper.clearTvShowList();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     Size mySize = MediaQuery.sizeOf(context);
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 // log("Welcome to the World");
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.practicePage,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.loginPage,
//                 // );
//                 GoRouter.of(context).pushNamed(
//                   MyAppRouteConstants.mainPage,
//                 );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.peopleDetailsPage,
//                 //   extra: 500,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.tvShowDetailsPage,
//                 //   extra: 1400,
//                 // );
//               },
//               child: const Text('Login'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//!-------------------------Improve UI of the page-------------------------
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:netflix/config/app_constants.dart';

class DemoStartingPage extends StatefulWidget {
  const DemoStartingPage({super.key});

  @override
  State<DemoStartingPage> createState() => _DemoStartingPageState();
}

class _DemoStartingPageState extends State<DemoStartingPage> {
  final inputController = TextEditingController();
  bool isloading = false;

  //--------------Setting up the model at first--------------------
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: GeminiConstants.apiKey,
  );

  late final ChatSession session;

  @override
  void initState() {
    session = model.startChat();
    super.initState();
    inputController.text = GeminiConstants.prompt;
    sendMessage();
  }
  //-----------------Intialization part upto here-------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ...session.history.map((content) {
                var text = content.parts
                    .whereType<TextPart>()
                    .map<String>((e) => e.text)
                    .join('');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isloading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: MarkdownBody(
                              data: text,
                            ),
                          ),
                    const Divider(),
                    const SizedBox(height: 10.0)
                  ],
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: inputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your prompt',
                  ),
                  onEditingComplete: () {
                    if (!isloading) {
                      sendMessage();
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        )
      ]),
    );
  }

  sendMessage() async {
    setState(() {
      isloading = true;
    });
    try {
      final response =
          await session.sendMessage(Content.text(inputController.text));
      var text = response.text;
      log(response.text.toString());
      if (text == null) {
        log("No response from the API");
      } else {
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      //Finally ma vayeko code, exception aayepani naaye pani run hunxa jasari ni
      inputController.clear();
      setState(() {
        isloading = false;
      });
    }
  }
}
