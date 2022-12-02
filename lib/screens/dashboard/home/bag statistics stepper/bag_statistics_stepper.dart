import 'package:diamond_bag_tracking/models/bag_statistics_model.dart';
import 'package:diamond_bag_tracking/models/bag_status_model.dart';
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import '../../../../widgets/customappbarbackwidget.dart';
import '../../../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class BagStatisticsStepper extends StatefulWidget {
  const BagStatisticsStepper({super.key});

  @override
  State<BagStatisticsStepper> createState() => _BagStatisticsStepperState();
}

class _BagStatisticsStepperState extends State<BagStatisticsStepper> {
  BagStatisticsModel bagStatistics = BagStatisticsModel(data: []);
  int tabId = 0;
  bool isLoading = true;
  int isClick = 0;

  @override
  void initState() {
    getTargetData(tabId);
    super.initState();
  }

  getTargetData(int tabId) async {
    isLoading = true;
    if (bagStatistics.data!.isNotEmpty) {
      setState(() {
        bagStatistics.data?.clear();
      });
    }
    await ApiProvider().getBagStatisticsData(tabId).then((reponse) {
      isLoading = false;
      if (reponse.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reponse.error.toString()),
          ),
        );
      } else {
        bagStatistics = reponse;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBackWidget(context),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  textAlign: TextAlign.start,
                  kBagStatistics,
                  style: Theme.of(context).textTheme.headline2,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isClick = 0;
                      });
                      getTargetData(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isClick == 0 ? Colors.blue : Colors.grey,
                    ),
                    child: Text('Today',
                        style: TextStyle(
                            color: isClick == 0 ? Colors.white : Colors.black)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClick = 1;
                    });
                    getTargetData(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isClick == 1 ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    'Week',
                    style: TextStyle(
                        color: isClick == 1 ? Colors.white : Colors.black),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: bagStatistics.data!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      alignment: Alignment.center,
                                      // padding: EdgeInsets.all(16.0),
                                      child: SvgPicture.asset(
                                        iconShoppingCart,
                                        height: 25,
                                        width: 25,
                                        fit: BoxFit.fill,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(bagStatistics.data![index].process!.contains("Fluting")){
                                        Navigator.pushNamed(
                                            context, bagStatisticsFlutingScreen);
                                      };
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bagStatistics.data![index].process!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: Colors.white38,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            color: const Color(0xFFE6E5E5),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 8),
                                          child: Text(
                                            bagStatistics.data![index].pCount
                                                .toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 30,
                              color: Colors.grey,
                              width: 2,
                              margin: const EdgeInsets.only(left: 25),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                      itemCount: bagStatistics.data!.length)
                  : isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(child: Text("Data Not Found")),
            )
          ],
        ),
      ),
    );
  }
}
