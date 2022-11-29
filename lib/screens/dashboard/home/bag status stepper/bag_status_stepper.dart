import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/customappbarbackwidget.dart';

class BagStatusStepper extends StatefulWidget {
  const BagStatusStepper({super.key});

  @override
  State<BagStatusStepper> createState() => _BagStatusStepperState();
}

class _BagStatusStepperState extends State<BagStatusStepper> {
  List<String> list = [
    'Buying',
    'Selection',
    'Assortment',
    'Fluting',
    'Packing',
    'Dispatch'
  ];
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, bagStatusTableScreen);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text('Bag Details'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index],
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: const Color(0xFFE6E5E5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 8),
                                        child: const Text(
                                          '11-01-2022',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: const Color(0xFFE6E5E5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 8),
                                        child: const Text(
                                          '01:30 pm',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
                  itemCount: list.length),
            )
          ],
        ),
      ),
    );
  }
}
