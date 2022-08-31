import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/constants.dart';
import 'package:weather/presentation/shared_widgets/my_text.dart';
import 'package:weather/utils/styles/colors.dart';

import '../../../utils/styles/cosntants.dart';
import '../../../utils/styles/spaces.dart';

class TemperatureForecastingContainer extends StatelessWidget {
  final List temps;
  const TemperatureForecastingContainer({
    Key? key,
    required this.temps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: temps.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  text: '3 pm',
                  size: fontSizeM - 2,
                  fontWeight: FontWeight.normal),
              K_vSpace10,
              const Icon(
                CupertinoIcons.sun_min_fill,
                size: 28,
                color: Colors.amber,
              ),
              K_vSpace10,
              MyText(
                text: '${temps[index]}$degreeSymbol',
                size: fontSizeM - 2,
                fontWeight: FontWeight.normal,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 3,
                    bottom: setPadding(index),
                  ),
                  child: Transform.rotate(
                    angle: setAngle(index),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: whiteColor,
                          size: 10.0,
                        ),
                        Container(
                          color: whiteColor,
                          width: index + 1 != temps.length ? 58.0 : 0.0,
                          height: 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double setAngle(int index) {
    return index + 1 < temps.length && temps[index + 1] < temps[index]
        ? 0.019 //This means that the angle will be a little bit lower to express that the next temp will be lower than the current temp
        : index + 1 < temps.length && temps[index + 1] > temps[index]
            ? -0.01 //This means that the angle will be a little bit higher to express that the next temp will be higher than the current temp
            : 0.0; //This means that the angle will not change to express that the next temp will be equal to the current temp
  }

  double setPadding(int index) {
    return temps[index] < 50.0 && temps[index] > 0.0
        ? temps[index].toDouble()
        : temps[index].toDouble() < 0.0
            ? 0.0
            : 48.0;
  }
}
