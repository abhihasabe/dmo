import 'package:diamond_bag_tracking/bloc/login_bloc.dart';
import 'package:diamond_bag_tracking/screens/dashboard/dashboard.dart';
import 'package:diamond_bag_tracking/screens/dashboard/home/bag%20status%20stepper/bag_status_stepper.dart';
import 'package:diamond_bag_tracking/screens/dashboard/home/bag%20status%20table/bag_status_table.dart';
import 'package:diamond_bag_tracking/screens/dashboard/home/homescreen.dart';
import 'package:diamond_bag_tracking/screens/dashboard/home/targets/targetsScreen.dart';
import 'package:diamond_bag_tracking/screens/dashboard/setting/settingscreen.dart';
import 'package:diamond_bag_tracking/screens/dashboard/user/userscreen.dart';
import 'package:diamond_bag_tracking/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/login/login.dart';
import 'utils/constants.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: const Login(),
      onGenerateRoute: (settings) {
        debugPrint('generated route is - ${settings.name}');
        Widget page = const Login();
        switch (settings.name) {
          case loginScreen:
            page = const Login();
            break;
          case dashBoardScreen:
            page = const DashBoard();
            break;
          case homeScreen:
            page = const HomeScreen();
            break;
          case targetsScreen:
            page = const TargetScreen();
            break;
          case userProfileScreen:
            page = const UserScreen();
            break;
          case settingsScreen:
            page = const SettingsScreen();
            break;
          case bagStatusStepperScreen:
            page = const BagStatusStepper();
            break;
          case bagStatusTableScreen:
            page = const BagStatusTableScreen();
            break;
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}
