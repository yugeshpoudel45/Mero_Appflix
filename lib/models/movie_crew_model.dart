import 'package:flutter/material.dart';

import '../config/app_local_assets.dart';

class MovieCrewModel extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  const MovieCrewModel({
    Key? key,
    required this.image,
    required this.name,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(AppAssets.onBoard1),
        ),
        SizedBox(
          width: mySize.width / 32,
        ),
        Column(
          children: [
            SizedBox(
              width: mySize.width / 4,
              child: Text(
                "James Cameron",
                style: myTextTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: mySize.width / 4,
              child: Text(
                "Director",
                style: myTextTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
