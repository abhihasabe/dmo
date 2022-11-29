import 'package:diamond_bag_tracking/utils/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/customappbarbackwidget.dart';

class BagStatusTableScreen extends StatefulWidget {
  const BagStatusTableScreen({super.key});

  @override
  State<BagStatusTableScreen> createState() => _BagStatusTableScreenState();
}

class _BagStatusTableScreenState extends State<BagStatusTableScreen> {
  var rowSpacer = const TableRow(children: [
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    ),
    SizedBox(
      height: 8,
    )
  ]);
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
                  kBagStatus,
                  style: Theme.of(context).textTheme.headline2,
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 1,
              autofocus: false,
              autocorrect: false,

              // onSaved: _authController.setMobileNo,
              keyboardType: const TextInputType.numberWithOptions(),
              // enabled: !_authController.isOtpFieldVisible.value,
              decoration: InputDecoration(
                  labelText: kBagNo, suffixIcon: const Icon(Icons.search)),
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly,
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
            Row(
              children: [
                Expanded(
                  flex: 3,
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFE6E5E5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Order Date'),
                     Text('11-01-2022',style: Theme.of(context).textTheme.headline6,),
                  ]),
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFE6E5E5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Expiry Delivery Date'),
                     Text('11-01-2022',style: Theme.of(context).textTheme.headline6,),
                  ]),
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFE6E5E5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text('Actual Delivery Date',style: Theme.of(context).textTheme.subtitle1,),
                     Text('11-01-2022',style: Theme.of(context).textTheme.headline6,),
                  ]),
                ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Table(
              border: TableBorder.all(
                  color: const Color(0xFFE5E5E4),
                  style: BorderStyle.solid,
                  width: 1),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(3),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(2),
              },
              children: [
                const TableRow(
                    decoration: BoxDecoration(color: kPrimaryColor),
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sr',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Shape',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Size',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Quality',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Pcs',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'CTS',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ]),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(
                      color: const Color(0xFFE5E5E4),
                      style: BorderStyle.solid,
                      width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(3),
                    4: FlexColumnWidth(2),
                    5: FlexColumnWidth(2),
                  },
                  children: [
                    for (int i = 0; i < 10; i++)
                      TableRow(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '$i',
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'EM',
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '0.002',
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'WA',
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '10',
                              ),
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '0.75',
                              ),
                            )),
                      ]),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFE6E5E5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total PCS'),
                          const Text('100'),
                        ]),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFE6E5E5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total CTS'),
                          const Text('00.2002'),
                        ]),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
