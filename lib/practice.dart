import 'package:flutter/material.dart';
import 'package:netflix/components/shimmers/shimmer_widget.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          ShimmerWidget(
            height: 200,
            width: double.infinity,
          ),
          SizedBox(height: 16),
          ShimmerWidget(
            height: 20,
            width: 100,
          ),
        ],
      ),
    );
  }
}
