import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../components/buttons/other_buttons/bottom_sheet_buttons.dart';

class RatingModal extends StatelessWidget {
  const RatingModal({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Container(
      height: mySize.height / 2.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.horizontal_rule_rounded,
            size: 56,
            color: Colors.grey.shade400,
          ),
          Text(
            "Give Rating",
            style: myTextTheme.headlineSmall,
          ),
          const Divider(),
          SizedBox(
            height: mySize.height / 64,
          ),
          RatingBar(
            minRating: 0.5,
            initialRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: Icon(
                CupertinoIcons.star_fill,
                color: myColorScheme.onTertiary,
              ),
              half: Icon(
                CupertinoIcons.star_lefthalf_fill,
                color: myColorScheme.onTertiary,
              ),
              empty: Icon(
                CupertinoIcons.star,
                color: myColorScheme.onTertiary,
              ),
            ),
            updateOnDrag: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              log(rating.toString());
            },
          ),
          BottomSheetButtons(
            buttonText1: "Cancel",
            buttonText2: "Submit",
            func1: () {
              Navigator.of(context).pop();
            },
            func2: () {
              log("Rating Submitted");
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
