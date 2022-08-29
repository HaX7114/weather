import 'package:flutter/material.dart';
import 'package:weather/utils/styles/spaces.dart';
import '../../../data/constants.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/cosntants.dart';
import '../../shared_widgets/my_text.dart';

class DrawerListItem extends StatelessWidget {
  final locationName;
  final degree;
  bool isFavoriteItem;
  DrawerListItem(
      {Key? key,
      required this.locationName,
      required this.degree,
      this.isFavoriteItem = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isFavoriteItem ? 20.0 : 35.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_pin,
                size: isFavoriteItem ? 15.0 : 0.0,
                color: whiteColor,
              ),
              K_hSpace10,
              MyText(
                text: locationName,
                size: fontSizeM,
                fontWeight:
                    isFavoriteItem ? FontWeight.bold : FontWeight.normal,
                color:
                    isFavoriteItem ? whiteColor : whiteColor.withOpacity(0.7),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.circle,
                color: Colors.amber,
              ),
              K_hSpace10,
              MyText(
                text: '$degree$degreeSymbol',
                size: fontSizeM,
                color: whiteColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              )
            ],
          )
        ],
      ),
    );
  }
}
