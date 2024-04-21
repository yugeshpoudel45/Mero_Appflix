import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CupertinoSearchTextField(),
              Icon(CupertinoIcons.color_filter),
            ],
          ),
        ],
      ),
    );
  }
}
