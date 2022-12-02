// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.

import 'package:diamond_bag_tracking/models/authenticate_model.dart';
import 'package:diamond_bag_tracking/models/validate_otp_model.dart';

import '../rest api/apiprovider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<AuthenticateModel> authenticate(String mobileNumber) async {
    return await _provider.isAuthenticate(mobileNumber);
  }

  Future<ValidateOTPModel> generateOTP(String otp) async {
    return await _provider.generateOTP(otp);
  }
}
