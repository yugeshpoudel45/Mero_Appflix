import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config/app_constants.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final String accessUrl =
      'https://api.themoviedb.org/3/trending/movie/day?language=en-US';

  Future<void> _fetchTrendingMovies() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response =
          await http.get(Uri.parse(accessUrl), headers: headers);
      log("Hello World");
      log(response.statusCode.toString());
      log(response.body.toString());
    } catch (e) {
      log("Exception caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _fetchTrendingMovies();
            });
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

// class StartingPage extends StatelessWidget {
//   const StartingPage({super.key});

//   final String sessionId = 'b29f944963dbbeb77f54a60d07466503';

//   Future<void> saveToken() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     sp.setString("token", sessionId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             saveToken();
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const MainPage(),
//               ),
//             );
//           },
//           child: const Text('Login'),
//         ),
//       ),
//     );
//   }
// }
