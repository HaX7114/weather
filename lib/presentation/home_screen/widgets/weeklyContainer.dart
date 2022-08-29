import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/presentation/home_screen/widgets/day_weather_details.dart';

import '../../../data/constants.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/cosntants.dart';
import '../../shared_widgets/my_text.dart';

class WeeklyContainer extends StatelessWidget {
  final List days;
  const WeeklyContainer({
    Key? key,
    required this.days,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //Temp row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  fontWeight: FontWeight.normal,
                  text: "Tomorrow",
                  size: fontSizeM,
                  color: whiteColor.withOpacity(0.7),
                ),
                MyText(
                  color: whiteColor.withOpacity(0.7),
                  fontWeight: FontWeight.normal,
                  text: "34$degreeSymbol 24$degreeSymbol",
                  size: fontSizeM,
                ),
              ],
            ),
            ListView.builder(
              itemCount: days.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DayWeatherDetailsContainer(
                  day: '${days[index]}',
                  humidity: '8',
                  minTemp: '24',
                  maxTemp: '34',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
