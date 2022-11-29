// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.

import 'package:diamond_bag_tracking/models/generateOtpModel.dart';

import '../rest api/apiprovider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<GenerateOtpModel> generateOTP(String mobileNumber) async {
    return await _provider.generateOTP(mobileNumber);
  }
}
