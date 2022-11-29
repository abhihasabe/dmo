import 'package:diamond_bag_tracking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/customappbarbackwidget.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  List<String> list = ['23', '24', '25', '26', '27', '28', '29', '30'];
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
                  kTargets,
                  style: Theme.of(context).textTheme.headline2,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Today'),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Week',
                    style: TextStyle(color: Colors.black),
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
                  'Total 45 Bags',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Row(
                  children: [
                    const Text(
                      '100 PCS',
                      style: TextStyle(color: Color(0xFFE5E5E4)),
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
                    const Text('0.50CTS',
                        style: TextStyle(color: Color(0xFFE5E5E4))),
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
              child: ListView.separated(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          'GE134573${list[index]}',
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
                                              '1${list[index]} PCS',
                                              style: const TextStyle(
                                                  color: Colors.black),
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
                                            const Text('0.50CTS',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Order No : ${list[index]}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    )),
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
                  itemCount: list.length),
            )
          ],
        ),
      ),
    );
  }
}
