// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.
import 'package:diamond_bag_tracking/screens/dashboard/home/homescreen.dart';
import 'package:diamond_bag_tracking/screens/dashboard/setting/settingscreen.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/appbar custom painter/appbarcustompainter.dart';
import 'user/userscreen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int selectedIndex = 1;
  List<Widget> widgetList = [
    const UserScreen(),
    const HomeScreen(),
    const SettingsScreen(),
  ];

  setBottomBarIndex(index) {
    debugPrint('selected bottom index is - $index');
    if (mounted) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    iconMenu,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
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
            ),
            body: Stack(
              children: [
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 58),
                    child: widgetList[selectedIndex]),
                Positioned(
                  bottom: 0,
                  left: 0,
                  height: 58,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.black12,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setBottomBarIndex(0);
                                },
                                child: Icon(
                                  Icons.person,
                                  color: selectedIndex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                )),
                            InkWell(
                                onTap: () {
                                  setBottomBarIndex(1);
                                },
                                child: Icon(Icons.home,
                                    color: selectedIndex == 1
                                        ? Colors.black
                                        : Colors.grey)),
                            InkWell(
                                onTap: () {
                                  setBottomBarIndex(2);
                                },
                                child: Icon(Icons.settings,
                                    color: selectedIndex == 2
                                        ? Colors.black
                                        : Colors.grey)),
                          ]),
                    ),
                  ),
                )
              ],
            )));
  }
}
