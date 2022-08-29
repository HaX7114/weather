import 'package:flutter/material.dart';
import 'package:weather/presentation/drawer/widgets/drawer_list_item.dart';
import 'package:weather/presentation/drawer/widgets/drawer_title.dart';
import 'package:weather/presentation/drawer/widgets/footer_row.dart';
import 'package:weather/presentation/shared_widgets/my_button.dart';
import 'package:weather/utils/styles/colors.dart';
import 'package:weather/utils/styles/device_dimensions.dart';
import 'package:weather/utils/styles/spaces.dart';

import '../../utils/styles/cosntants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: const Color(0XFF2E3842),
        ),
        height: double.infinity,
        width: DeviceDimensions.getWidthOfDevice(context) * 0.8,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.settings_outlined,
                        color: whiteColor,
                        size: 25.00,
                      ),
                    ],
                  ),
                  K_vSpace20,
                  DrawerTitle(
                    title: 'Favourite location',
                    icon: Icons.star_rounded,
                    setInfo: true,
                  ),
                  K_vSpace20,
                  //List of favorites
                  DrawerListItem(
                      locationName: 'El Hay El Asher',
                      degree: '34',
                      isFavoriteItem: true),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(color: whiteColor, thickness: 1.0),
                  ),
                  DrawerTitle(
                      title: 'Other locations',
                      icon: Icons.add_location_outlined),
                  K_vSpace20,
                  //List of locations
                  DrawerListItem(locationName: 'El Hay El Asher', degree: '34'),
                  K_vSpace20,
                  MyButton(
                    fillColor: whiteColor.withOpacity(0.2),
                    text: 'Manage locations',
                    height: 50.0,
                    textSize: fontSizeM,
                    textColor: whiteColor.withOpacity(0.7),
                    onPressed: () {},
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(color: whiteColor, thickness: 1.0),
                  ),
                  const FooterRow(
                      title: 'Report wrong location', icon: Icons.info_outline),
                  K_vSpace20,
                  const FooterRow(
                      title: 'Contact us', icon: Icons.headset_mic_outlined),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
