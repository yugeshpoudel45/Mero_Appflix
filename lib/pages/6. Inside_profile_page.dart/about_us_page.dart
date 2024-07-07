import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: myTextTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: myColorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hi, My name is Yugesh Poudel.',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'I am a software developer from Nepal.',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'I specialize in creating robust and efficient software solutions. '
                      'With a passion for coding and problem-solving, I strive to deliver high-quality applications '
                      'that meet the needs of my clients and users. My expertise includes a range of programming languages '
                      'and technologies, and I am always eager to learn and adopt new skills to stay current in the fast-paced '
                      'world of software development.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Email: yugesh.poudel.45@gmail.com',
                    ),
                    Text(
                      '@yugeshpoudel45',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
