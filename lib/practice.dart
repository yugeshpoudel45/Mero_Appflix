import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String myRequestToken = '';

  Future<void> requestToken() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/authentication/token/new'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWFjMzQ3MGRjNzg4YmY5MGFkODkyZDQyMjMzNDc2OCIsInN1YiI6IjY1YTBlOGY3Njc4MjU5MDEyZmU4Yzk0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hvJqQiiizeG_FXrBZWOpFA5qloqU8Rf_CtJt7bufJZw"
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            myRequestToken =
                jsonDecode(response.body)["request_token"] as String;
          },
        );
        log('Token: ${response.body}');
        // log('Request Token: $myRequestToken');
      } else {
        log('Failed to get token');
      }
    } catch (e) {
      log('Request Token wala exception$e');
    }
  }

  // Future<void> askPermission() async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse(
  //           "https://api.themoviedb.org/3/authentication/a1c63ede968b8e1b55b82e9e93207ca882c69494"),
  //       headers: {
  //         "accept": "application/json",
  //         'Authorization':
  //             "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWFjMzQ3MGRjNzg4YmY5MGFkODkyZDQyMjMzNDc2OCIsInN1YiI6IjY1YTBlOGY3Njc4MjU5MDEyZmU4Yzk0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hvJqQiiizeG_FXrBZWOpFA5qloqU8Rf_CtJt7bufJZw"
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       log('Validate Body: ${response.body}');
  //     } else {
  //       log('Failed to validate with login');
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log('Validate wala exception$e');
  //   }
  // }

  Future<void> validateWithLogin() async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              "https://api.themoviedb.org/3/authentication/token/validate_with_login"),
          headers: {
            "accept": "application/json",
            'Authorization':
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWFjMzQ3MGRjNzg4YmY5MGFkODkyZDQyMjMzNDc2OCIsInN1YiI6IjY1YTBlOGY3Njc4MjU5MDEyZmU4Yzk0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hvJqQiiizeG_FXrBZWOpFA5qloqU8Rf_CtJt7bufJZw"
          },
          body: {
            'username': usernameController.text,
            'password': passwordController.text,
            'request_token': myRequestToken,
          });

      if (response.statusCode == 200) {
        log('Validate Body: ${response.body}');
      } else {
        log('Failed to validate with login');
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('Validate wala exception$e');
    }
  }

  Future<void> getSessionId() async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://api.themoviedb.org/3//authentication/session/new"),
          headers: {
            "accept": "application/json",
            'Authorization':
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNWFjMzQ3MGRjNzg4YmY5MGFkODkyZDQyMjMzNDc2OCIsInN1YiI6IjY1YTBlOGY3Njc4MjU5MDEyZmU4Yzk0OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hvJqQiiizeG_FXrBZWOpFA5qloqU8Rf_CtJt7bufJZw"
          },
          body: {
            'request_token': "414eb8009bff285f800c10b1363a1209b60e94dd",
          });

      if (response.statusCode == 200) {
        log('Validate Body: ${response.body}');
      } else {
        log('Failed to validate with login');
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('Validate wala exception$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await requestToken();
              },
              child: const Text('Validate'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await askPermission();
                // await validateWithLogin();
                await getSessionId();
              },
              child: const Text('User Permission wala validate',),
            ),
          ],
        ),
      ),
    );
  }
}
