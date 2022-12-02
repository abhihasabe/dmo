import 'package:diamond_bag_tracking/rest%20api%20repo/apirepository.dart';
import 'package:diamond_bag_tracking/screens/dashboard/dashboard.dart';
import 'package:diamond_bag_tracking/helper/dialog.helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/logo_widgets.dart';
import '../../widgets/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _authController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isOtpTextFieldVisible = false;
  ApiRepository apiRepository = ApiRepository();
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }

  initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShadowCard(
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      !isOtpTextFieldVisible
                          ? TextFormField(
                              controller: _authController,
                              maxLines: 1,
                              autofocus: false,
                              autocorrect: false,
                              //onSaved: _authController.setMobileNo,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              //enabled: !_authController.isOtpFieldVisible.value,
                              decoration:
                                  InputDecoration(labelText: kMobileNumber),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (input) {
                                if (input!.isEmpty || input.length < 10) {
                                  return kEnterMobileNo;
                                }

                                return null;
                              },
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      isOtpTextFieldVisible
                          ? TextFormField(
                              controller: _otpController,
                              maxLines: 1,
                              autofocus: false,
                              autocorrect: false,
                              // onSaved: _authController.setMobileNo,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              // enabled: !_authController.isOtpFieldVisible.value,
                              decoration: InputDecoration(labelText: kOtp),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (input) {
                                if (input!.isEmpty || input.length < 4) {
                                  return kEnterOTP;
                                }
                                return null;
                              },
                            )
                          : Container(),
                      isOtpTextFieldVisible
                          ? const SizedBox(
                              height: 20,
                            )
                          : Container(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (isOtpTextFieldVisible == true) {
                              DialogHelper.showLoaderDialog(context);
                              apiRepository
                                  .generateOTP(_otpController.text)
                                  .then((value) {
                                DialogHelper.dismissDialog(context);
                                if (value.data != null &&
                                    value.data![0].status == 1) {
                                  prefs?.setString(kToken,
                                      value.details![0].token.toString());
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DashBoard(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  DialogHelper.showToast(
                                      context, "Invalid OTP");
                                }
                              });
                            } else {
                              DialogHelper.showLoaderDialog(context);
                              apiRepository
                                  .authenticate(_authController.text)
                                  .then((value) {
                                DialogHelper.dismissDialog(context);
                                if (value.data![0].status == 1) {
                                  setState(() {
                                    isOtpTextFieldVisible = true;
                                  });
                                } else {
                                  DialogHelper.showToast(
                                      context, value.data![0].message!);
                                }
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          // backgroundColor: const Color(0xFFFFCB05),
                          padding: const EdgeInsets.only(left: 40, right: 40),
                        ),
                        child: Text(
                          isOtpTextFieldVisible ? kGetOTp : kVerify,
                        ),
                      )
                    ],
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
