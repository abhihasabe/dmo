import 'package:diamond_bag_tracking/rest%20api%20repo/apirepository.dart';
import 'package:diamond_bag_tracking/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';
import '../../widgets/logo_widgets.dart';
import '../../widgets/shadow_card.dart';

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
              Container(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _authController,
                          maxLines: 1,
                          autofocus: false,
                          autocorrect: false,
                          //onSaved: _authController.setMobileNo,
                          keyboardType: const TextInputType.numberWithOptions(),
                          //enabled: !_authController.isOtpFieldVisible.value,
                          decoration: InputDecoration(labelText: kMobileNumber),
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
                        ),
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
                                apiRepository
                                    .generateOTP(_otpController.text)
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DashBoard(),
                                    ),
                                    (route) => false,
                                  );
                                });
                              } else {
                                apiRepository
                                    .authenticate(_authController.text)
                                    .then((value) {
                                  print("object: $value");
                                  setState(() {
                                    isOtpTextFieldVisible = true;
                                  });
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
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
