import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:netflix/config/app_constants.dart';

import '../../config/app_local_assets.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final inputController = TextEditingController();
  bool isloading = false;
  bool isButtonPressed = false;

  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: GeminiConstants.apiKey,
  );

  late final ChatSession session;
  List<Content> localHistory = [];

  @override
  void initState() {
    super.initState();
    session = model.startChat();
    _sendInitialPrompt();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  height: mySize.height / 24,
                ),
                SizedBox(
                  width: mySize.width / 32,
                ),
                Text(
                  "Movie Talks with AI",
                  style: myTextTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ], 
            ),
          ),
          // SizedBox(
          //   height: mySize.height / 16,
          // ),
          isloading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : !isButtonPressed
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            constraints: BoxConstraints(
                              maxWidth: mySize.width / 1.4,
                            ),
                            decoration: BoxDecoration(
                              color: myColorScheme.onTertiary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 16,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: const Text(
                              GeminiConstants.welcomeMessage,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16.0),
                        itemCount: localHistory.length,
                        itemBuilder: (context, index) {
                          var content = localHistory[index];
                          var text = content.parts
                              .whereType<TextPart>()
                              .map<String>((e) => e.text)
                              .join('');
                          bool isUser = index % 2 == 0;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: mySize.width / 1.4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? myColorScheme.onTertiary
                                        : myColorScheme.secondary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(16),
                                      topRight: const Radius.circular(16),
                                      bottomLeft: isUser
                                          ? const Radius.circular(16)
                                          : const Radius.circular(0),
                                      bottomRight: isUser
                                          ? const Radius.circular(0)
                                          : const Radius.circular(16),
                                    ),
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.all(12.0),
                                  child: MarkdownBody(
                                    data: text,
                                    styleSheet: MarkdownStyleSheet(
                                      p: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(),
                              const SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: mySize.width / 1.3,
                    ),
                    child: TextField(
                      // autofocus: true,
                      controller: inputController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter your prompt',
                        filled: true,
                        fillColor: myColorScheme.onInverseSurface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: myColorScheme.secondaryContainer,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: myColorScheme.secondaryContainer,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: myColorScheme.onTertiary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onEditingComplete: () {
                        if (!isloading) {
                          sendMessage();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: mySize.width / 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: myColorScheme.secondaryContainer,
                        padding: const EdgeInsets.all(18),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          isButtonPressed = true;
                        });
                        sendMessage();
                      },
                      icon: const Icon(
                        Icons.arrow_upward_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  Future<void> _sendInitialPrompt() async {
    try {
      await session.sendMessage(Content.text(GeminiConstants.prompt));
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  sendMessage() async {
    setState(() {
      isloading = true;
    });
    try {
      final userMessage = Content.text(inputController.text);
      final response = await session.sendMessage(userMessage);
      var text = response.text;
      // log(response.text.toString());
      if (text == null) {
        log("No response from the API");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No response from the API'),
            ),
          );
        }
      } else {
        setState(() {
          _scrollDown();
          localHistory.add(userMessage); // Add user message to local history
          // Convert the response to Content type
          localHistory.add(Content.text(
              response.text!)); // Add model response to local history
        });
      }
    } catch (e) {
      if (context.mounted) {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      inputController.clear();
      setState(() {
        isloading = false;
      });
    }
  }
}
