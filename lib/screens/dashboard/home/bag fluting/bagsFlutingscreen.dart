import 'package:diamond_bag_tracking/widgets/customappbarbackwidget.dart';
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import 'package:diamond_bag_tracking/models/bags_fluting.dart';
import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BagFlutingScreen extends StatefulWidget {
  const BagFlutingScreen({super.key});

  @override
  State<BagFlutingScreen> createState() => _BagFlutingScreenState();
}

class _BagFlutingScreenState extends State<BagFlutingScreen> {
  BagsFlutingModel bagsFlutingModel = BagsFlutingModel(data: []);
  int tabId = 0, pcs = 0;
  double cts = 0.0;
  bool isLoading = true;
  int isClick = 0;

  @override
  void initState() {
    getTargetData(tabId);
    super.initState();
  }

  getTargetData(int tabId) async {
    pcs = 0;
    cts = 0.0;
    isLoading = true;
    if (bagsFlutingModel.data!.isNotEmpty) {
      setState(() {
        bagsFlutingModel.data?.clear();
      });
    }
    await ApiProvider().getBagsFlutingData(tabId).then((reponse) {
      isLoading = false;
      if (reponse.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reponse.error.toString()),
          ),
        );
      } else {
        bagsFlutingModel = reponse;
        setState(() {});
        if (bagsFlutingModel.data!.isNotEmpty) {
          for (int i = 0; i < bagsFlutingModel.data!.length; i++) {
            pcs = bagsFlutingModel.data![i].pcs! + pcs;
            cts = bagsFlutingModel.data![i].carats! + cts;
          }
        }
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
                  kBagFluting,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ${bagsFlutingModel.data?.length} Bags',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  children: [
                    Text(
                      '$pcs PCS',
                      style: const TextStyle(color: Color(0xFFE5E5E4)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: const Color(0xFFE5E5E4),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('${cts.toStringAsFixed(2)} CTS',
                        style: const TextStyle(color: Color(0xFFE5E5E4))),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: const Color(0xFFE5E5E4),
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: bagsFlutingModel.data!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(iconBox),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 60,
                                          width: 1,
                                          color: const Color(0xFFE5E5E4),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${bagsFlutingModel.data![index].bagNo}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${bagsFlutingModel.data![index].pcs} PCS',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 1,
                                                  color:
                                                      const Color(0xFFE5E5E4),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    '${bagsFlutingModel.data![index].carats}CTS',
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Order No : ${bagsFlutingModel.data![index].orderNo}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      softWrap: false,
                                      maxLines: 1,
                                    ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: bagsFlutingModel.data!.length)
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
