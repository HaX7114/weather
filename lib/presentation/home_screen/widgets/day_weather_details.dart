import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/constants.dart';
import 'package:weather/presentation/shared_widgets/my_text.dart';
import 'package:weather/utils/styles/spaces.dart';

import '../../../utils/styles/colors.dart';
import '../../../utils/styles/cosntants.dart';

class DayWeatherDetailsContainer extends StatelessWidget {
  final day;
  final humidity;
  final minTemp;
  final maxTemp;

  const DayWeatherDetailsContainer({
    Key? key,
    required this.day,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100.0,
          child: MyText(
            text: "$day",
            size: fontSizeM - 2,
          ),
        ),
        Row(
          children: [
            Icon(
              CupertinoIcons.drop_fill,
              size: 15,
              color: whiteColor.withOpacity(0.6),
            ),
            MyText(
              text: "$humidity%",
              size: fontSizeM - 4,
              color: whiteColor.withOpacity(0.6),
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        Row(
          children: const [
            Icon(
              CupertinoIcons.circle_fill,
              color: Colors.amber,
              size: 20,
            ),
            K_hSpace10,
            Icon(
              CupertinoIcons.moon_fill,
              color: Colors.amber,
              size: 20,
            ),
          ],
        ),
        MyText(
          fontWeight: FontWeight.normal,
          text: "$maxTemp$degreeSymbol $minTemp$degreeSymbol",
          size: fontSizeM,
        ),
      ],
    );
  }
}
