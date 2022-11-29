// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.

import 'package:flutter/material.dart';


import '../utils/constants.dart';
import '../utils/mytheme.dart';
import '../utils/text_styles.dart';

class LogoWidget extends StatelessWidget {
  final TextStyle? textStyle;
  final double width, height;

  const LogoWidget({super.key, this.textStyle, this.width = 115, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          const SizedBox(height: 20,),
        Image(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height * 0.1,
          image: AssetImage(iconDiamondLogo),
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 10,),
        Text(
          kAppName,
          style: textStyle ?? textStyle16Normal.copyWith(color: kDarkerGreyColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
