import 'package:flutter/material.dart';

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
        CircleAvatar(
          backgroundImage:
              NetworkImage("https://image.tmdb.org/t/p/original/$image"),
        ),
        SizedBox(
          width: mySize.width / 32,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: mySize.width / 6,
              child: Text(
                name,
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
                role,
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
