import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/utils/styles/colors.dart';

class MainProgressIndicator extends StatelessWidget {
  const MainProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: whiteColor.withOpacity(0.6),
        size: 50,
      ),
    );
  }
}
