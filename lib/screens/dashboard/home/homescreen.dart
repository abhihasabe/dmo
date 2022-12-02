// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import 'package:diamond_bag_tracking/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/dashboardmodel.dart';
import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _statusIdController = TextEditingController();
  bool isLoading = true;
  List<String> dataList = [
    'Target',
    'Delivery',
    'Status',
    'Customers',
    'Orders',
    'Bags',
  ];

  DashboardModel dashboardModel = DashboardModel(data: []);

  @override
  void initState() {
    getDahBoardData();
    super.initState();
  }

  getDahBoardData() async {
    await ApiProvider().getDashBoardData().then((reponse) {
      isLoading = false;
      if (reponse.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reponse.error.toString()),
          ),
        );
      } else {
        dashboardModel = reponse;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _statusIdController,
            maxLines: 1,
            autofocus: false,
            autocorrect: false,
            // enabled: !_authController.isOtpFieldVisible.value,
            decoration: InputDecoration(
                labelText: kBagEnquiry,
                suffixIcon: InkWell(
                    child: const Icon(Icons.search),
                    onTap: () {
                      Navigator.pushNamed(context, bagStatusStepperScreen,
                          arguments: _statusIdController.text);
                    })),
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
            ],
            validator: (input) {
              if (input!.isEmpty || input.length < 4) {
                return kEnterSomething;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: dashboardModel.data!.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: (() {
                            if (index == 0) {
                              Navigator.pushNamed(context, targetsScreen);
                            } else if (index == 2) {
                              Navigator.pushNamed(
                                  context, bagStatisticsStepperScreen);
                            } else if (index == 3) {
                              Navigator.pushNamed(
                                  context, bagBagListCustomCodeWiseScreen);
                            }
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 3,
                                      color: kPrimaryColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          dashboardModel.data![index].key!
                                              .split(' ')
                                              .first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                              dashboardModel.data![index].key!
                                                  .split(' ')
                                                  .last,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4))
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 120,
                                decoration:
                                    const BoxDecoration(color: kPrimaryColor),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                      ),
                                      child: dashboardModel.data![index].val !=
                                              -1
                                          ? Text(
                                              dashboardModel.data![index].val
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: Colors.white))
                                          : Image.asset(
                                              iconStatusIcon,
                                              height: 30,
                                              width: 30,
                                            ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: dashboardModel.data!.length)
                : isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(child: Text("Data Not Found")),
          )
        ],
      ),
    );
  }
}
