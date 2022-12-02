import 'package:diamond_bag_tracking/models/bags_list_customer_code_model.dart';
import 'package:diamond_bag_tracking/widgets/customappbarbackwidget.dart';
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BagListCustomCodeScreen extends StatefulWidget {
  BagListCustomCodeScreen({super.key, this.arguments});

  String? arguments;

  @override
  State<BagListCustomCodeScreen> createState() =>
      _BagListCustomCodeScreenState();
}

class _BagListCustomCodeScreenState extends State<BagListCustomCodeScreen> {
  BagsListCustomerCodeModel bagsListCustomerCodeModel =
      BagsListCustomerCodeModel(data: []);
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
    isLoading = true;
    if (bagsListCustomerCodeModel.data!.isNotEmpty) {
      setState(() {
        bagsListCustomerCodeModel.data?.clear();
      });
    }
    await ApiProvider()
        .getBagsListCustomerCodeData(tabId, widget.arguments!)
        .then((reponse) {
      isLoading = false;
      if (reponse.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reponse.error.toString()),
          ),
        );
      } else {
        bagsListCustomerCodeModel = reponse;
        setState(() {});
        if (bagsListCustomerCodeModel.data!.isNotEmpty) {
          for (int i = 0; i < bagsListCustomerCodeModel.data!.length; i++) {
            pcs = bagsListCustomerCodeModel.data![i].pcs! + pcs;
            cts = bagsListCustomerCodeModel.data![i].carats! + cts;
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
                  "$kCustomerCode : ${widget.arguments}",
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
                      getTargetData(0);
                      setState(() {
                        isClick = 0;
                      });
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
                  child: Text('Week',
                      style: TextStyle(
                          color: isClick == 1 ? Colors.white : Colors.black)),
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
                  'Total ${bagsListCustomerCodeModel.data?.length} Bags',
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
                child: bagsListCustomerCodeModel.data!.isNotEmpty
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${bagsListCustomerCodeModel.data![index].bagNo}',
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
                                                    '${bagsListCustomerCodeModel.data![index].pcs} PCS',
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
                                                      '${bagsListCustomerCodeModel.data![index].carats}CTS',
                                                      style: const TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Order No : ${bagsListCustomerCodeModel.data![index].orderNo}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
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
                        itemCount: bagsListCustomerCodeModel.data!.length)
                    : isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text("Data Not Found")))
          ],
        ),
      ),
    );
  }
}
