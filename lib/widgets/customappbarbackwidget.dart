import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'appbar custom painter/appbarcustompainter.dart';

AppBar customAppBarBackWidget(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    // leading: const Icon(
    //       Icons.arrow_back_ios,
    //       color: Colors.grey,
    //     ),
    leadingWidth: 30,
    centerTitle: false,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      const SizedBox(width: 10,),
        InkWell(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Image(
            image: AssetImage(iconDiamondLogo),
            height: 40,
          ),
        ),
      ],
    ),
    actions: [
      SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width / 2,
        child: CustomPaint(
          painter: AppBarCustomPainter(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white),
                child: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
