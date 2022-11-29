import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:diamond_bag_tracking/models/authenticate_model.dart';
import 'package:diamond_bag_tracking/models/dashboardmodel.dart';
import 'package:diamond_bag_tracking/models/validate_otp_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/generateOtpModel.dart';
import '../utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<Object> isAuthenticate(String mobileNumber) async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceName;
      String deviceId;

      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');
        deviceName = iosInfo.model!;
        deviceId = iosInfo.identifierForVendor!;
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.model} ${androidInfo.id}');
        deviceName = androidInfo.model;
        deviceId = androidInfo.id;
      } else {
        deviceName = 'NoData';
        deviceId = 'NoData';
      }

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(kMobileNumber, mobileNumber);
      prefs.setString(kDeviceID, deviceId);

      /*Map data = {
        "mobile_no": mobileNumber,
        "firebase_token": prefs.getString(kFirebaseToken),
        "device_id": deviceId,
        "device_name": deviceName,
        "firmware": null,
        "mac": null,
        "imei": deviceId,
        "session_id": 1
      };*/

      Map data = {
        "MobileNumber": "7021766266",
        "DeviceID": "1",
        "DeviceName": "MotoG",
        "IMEI": "SDSD54545",
        "GoogleToken": "SKEKED5SDSDkkSD4"
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kAuthenticateUser',
        data: body,
      );
      prefs.setString(kUserCode,
          "${AuthenticateModel.fromJson(response.data).data?[0].userCode}");
      debugPrint(
          'response from generate api is - ${response.data} ${AuthenticateModel.fromJson(response.data).data?[0].userCode}');
      return AuthenticateModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return GenerateOtpModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return GenerateOtpModel.withError(kServiceUnavailableError);
        } else {
          return GenerateOtpModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return GenerateOtpModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return GenerateOtpModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return GenerateOtpModel.withError(error.toString());
    }
  }

  Future<Object> generateOTP(String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "DeviceID": "1",
        "EnteredOTP": otp
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kValidateOTP',
        data: body,
      );
      debugPrint('response from generate api is - ${response.data}');
      return ValidateOTPModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return GenerateOtpModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return GenerateOtpModel.withError(kServiceUnavailableError);
        } else {
          return GenerateOtpModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return GenerateOtpModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return GenerateOtpModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return GenerateOtpModel.withError(error.toString());
    }
  }

  Future<DashboardModel> getdashBoardData() async {
    try {
      Map data = {"UserCode": "5864"};

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kAuthenticateUser',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      if (response.statusCode == 200) {
        List<DashBoardRealData> dashBoardRealData = response.data['Data']
            .map<DashBoardRealData>(
              (dashBoardRealData) =>
                  DashBoardRealData.fromJson(dashBoardRealData),
            )
            .toList();

        return DashboardModel(Data: dashBoardRealData);
      } else {
        debugPrint(
            'Data not found / Connection issue - ${response.statusCode}');
        return DashboardModel.withError(
            response.data['message'] ?? response.data.toString());
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return DashboardModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return DashboardModel.withError(kServiceUnavailableError);
        } else {
          return DashboardModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return DashboardModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return DashboardModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return DashboardModel.withError(error.toString());
    }
  }
}
