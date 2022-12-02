import 'package:diamond_bag_tracking/models/bags_list_customer_code_wise_model.dart';
import 'package:diamond_bag_tracking/widgets/customappbarbackwidget.dart';
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BagListCustomCodeWiseScreen extends StatefulWidget {
  const BagListCustomCodeWiseScreen({super.key});

  @override
  State<BagListCustomCodeWiseScreen> createState() =>
      _BagListCustomCodeWiseScreenState();
}

class _BagListCustomCodeWiseScreenState
    extends State<BagListCustomCodeWiseScreen> {
  BagsListCustomerCodeWiseModel bagsFlutingModel =
      BagsListCustomerCodeWiseModel(data: []);
  int pcs = 0;
  double cts = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    getTargetData();
    super.initState();
  }

  getTargetData() async {
    cts = 0.0;
    pcs = 0;
    isLoading = true;
    await ApiProvider().getBagsListCustomerCodeWiseData().then((reponse) {
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
                  kCustomerCode,
                  style: Theme.of(context).textTheme.headline2,
                )),
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
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, bagBagListCustomCodeScreen,
                                arguments:
                                    bagsFlutingModel.data![index].custCode);
                          },
                          child: Card(
                            elevation: 1,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bagsFlutingModel
                                                      .data![index].custShortCode
                                                      .toString(),
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
                                                        '${bagsFlutingModel.data![index].carats?.toStringAsFixed(2)} CTS',
                                                        style: const TextStyle(
                                                            color: Colors.black)),
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
                                                        '${bagsFlutingModel.data![index].orderCount} Order',
                                                        style: const TextStyle(
                                                            color: Colors.black)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 60,
                                            width: 1,
                                            color: const Color(0xFFE5E5E4),
                                          ),
                                          const SizedBox(
                                            width: 14,
                                          ),
                                          Text(
                                            '${bagsFlutingModel.data![index].totalBags}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            softWrap: false,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
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
