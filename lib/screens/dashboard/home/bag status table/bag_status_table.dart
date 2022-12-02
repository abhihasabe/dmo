import 'package:diamond_bag_tracking/models/bag_detail_model.dart';
import 'package:diamond_bag_tracking/rest%20api/apiprovider.dart';
import 'package:diamond_bag_tracking/utils/mytheme.dart';
import '../../../../widgets/customappbarbackwidget.dart';
import '../../../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BagStatusTableScreen extends StatefulWidget {
  BagStatusTableScreen({super.key, required, this.arguments});

  String? arguments;

  @override
  State<BagStatusTableScreen> createState() => _BagStatusTableScreenState();
}

class _BagStatusTableScreenState extends State<BagStatusTableScreen> {
  final TextEditingController _bagNumberController = TextEditingController();
  BagDetailModel bagDetailModel = BagDetailModel(data: []);
  bool isLoading = true;
  int pcs = 0;
  double carats = 0.0;

  getStatusSteeperData(String argument) async {
    await ApiProvider().getBagDetailData(argument).then((reponse) {
      isLoading = false;
      if (reponse.error != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reponse.error.toString()),
          ),
        );
      } else {
        bagDetailModel = reponse;
        setState(() {});
        if (bagDetailModel.data!.isNotEmpty) {
          for (var i = 0; i < bagDetailModel.data!.length; i++) {
            pcs = bagDetailModel.data![i].pcs! + pcs;
            carats = bagDetailModel.data![i].carats! + carats;
          }
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arguments != null) {
      getStatusSteeperData(widget.arguments!);
      _bagNumberController.text = widget.arguments!;
    }
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
                  kBagStatus,
                  style: Theme.of(context).textTheme.headline2,
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _bagNumberController,
              maxLines: 1,
              autofocus: false,
              autocorrect: false,
              // onSaved: _authController.setMobileNo,
              keyboardType: const TextInputType.numberWithOptions(),
              enabled: false,
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
            bagDetailModel.data!.isNotEmpty
                ? Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFFE6E5E5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Order Date'),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(bagDetailModel
                                            .data![0].orderDate!)),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Expiry Delivery Date'),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(bagDetailModel
                                            .data![0].expDelDate!)),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Actual Delivery Date',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(bagDetailModel
                                            .data![0].actualDelDate!)),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ]),
                          ))
                    ],
                  )
                : Container(),
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
              children: const [
                TableRow(
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
            bagDetailModel.data!.isNotEmpty
                ? Expanded(
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
                          for (int i = 0; i < bagDetailModel.data!.length; i++)
                            TableRow(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$i',
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bagDetailModel.data![i].shapeName!,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bagDetailModel.data![i].stoneSize!
                                          .toStringAsFixed(2),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bagDetailModel.data![i].qualityName!,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bagDetailModel.data![i].pcs!.toString(),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      bagDetailModel.data![i].carats!
                                          .toStringAsFixed(2),
                                    ),
                                  )),
                            ]),
                        ],
                      ),
                    ),
                  )
                : isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(child: Text("Data Not Found")),
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
                          Text('$pcs'),
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
                          Text('$carats'),
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
