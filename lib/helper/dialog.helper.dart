import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogHelper {
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      key: const ValueKey('loader'),
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16,
        backgroundColor: Colors.black12,
        webShowClose: true,
        textColor: Colors.black);
  }

  static void dismissDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBars(String text, Color bgColor, BuildContext context) {
    final snackBar = SnackBar(content: Text(text), backgroundColor: bgColor);
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
