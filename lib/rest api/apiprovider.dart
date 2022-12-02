import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:diamond_bag_tracking/models/authenticate_model.dart';
import 'package:diamond_bag_tracking/models/bag_detail_model.dart';
import 'package:diamond_bag_tracking/models/bag_statistics_model.dart';
import 'package:diamond_bag_tracking/models/bag_status_model.dart';
import 'package:diamond_bag_tracking/models/bags_fluting.dart';
import 'package:diamond_bag_tracking/models/bags_list_customer_code_model.dart';
import 'package:diamond_bag_tracking/models/bags_list_customer_code_wise_model.dart';
import 'package:diamond_bag_tracking/models/dashboardmodel.dart';
import 'package:diamond_bag_tracking/models/target_model.dart';
import 'package:diamond_bag_tracking/models/validate_otp_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<AuthenticateModel> isAuthenticate(String mobileNumber) async {
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

      Map data = {
        "MobileNumber": mobileNumber,
        "DeviceID": deviceId,
        "DeviceName": deviceName,
        "IMEI": deviceId,
        "GoogleToken": prefs.getString(kFirebaseToken)
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kAuthenticateUser',
        data: body,
      );
      debugPrint('response from generate api is - ${response.data}');
      prefs.setString(kUserCode,
          "${AuthenticateModel.fromJson(response.data).data?[0].userCode.toString()}");
      return AuthenticateModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return AuthenticateModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return AuthenticateModel.withError(kServiceUnavailableError);
        } else {
          return AuthenticateModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return AuthenticateModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return AuthenticateModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return AuthenticateModel.withError(error.toString());
    }
  }

  Future<ValidateOTPModel> generateOTP(String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "DeviceID": "${prefs.getString(kDeviceID)}",
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
        return ValidateOTPModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return ValidateOTPModel.withError(kServiceUnavailableError);
        } else {
          return ValidateOTPModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return ValidateOTPModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return ValidateOTPModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return ValidateOTPModel.withError(error.toString());
    }
  }

  Future<DashboardModel> getDashBoardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {"UserCode": "${prefs.getString(kUserCode)}"};

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagsDashbordDetails',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return DashboardModel.fromJson(response.data);
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

  Future<TargetModel> getTargetsBagsData(int tabId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "Weekly": tabId.toString()
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kTargetsBags',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return TargetModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return TargetModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return TargetModel.withError(kServiceUnavailableError);
        } else {
          return TargetModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return TargetModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return TargetModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return TargetModel.withError(error.toString());
    }
  }

  Future<BagStatusModel> getBagStatusStepperData(String bagNo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {"UserCode": "${prefs.getString(kUserCode)}", "BagNo": bagNo};

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagsStatus',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagStatusModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagStatusModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagStatusModel.withError(kServiceUnavailableError);
        } else {
          return BagStatusModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagStatusModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagStatusModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagStatusModel.withError(error.toString());
    }
  }

  Future<BagDetailModel> getBagDetailData(String bagNo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {"UserCode": "${prefs.getString(kUserCode)}", "BagNo": bagNo};

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagDetails',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagDetailModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagDetailModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagDetailModel.withError(kServiceUnavailableError);
        } else {
          return BagDetailModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagDetailModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagDetailModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagDetailModel.withError(error.toString());
    }
  }

  Future<BagStatisticsModel> getBagStatisticsData(int tabId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "Weekly": tabId.toString()
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagStatisticsData',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagStatisticsModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagStatisticsModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagStatisticsModel.withError(kServiceUnavailableError);
        } else {
          return BagStatisticsModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagStatisticsModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagStatisticsModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagStatisticsModel.withError(error.toString());
    }
  }

  Future<BagsFlutingModel> getBagsFlutingData(int tabId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "Weekly": tabId.toString()
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kFlutingBagsList',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagsFlutingModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagsFlutingModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagsFlutingModel.withError(kServiceUnavailableError);
        } else {
          return BagsFlutingModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagsFlutingModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagsFlutingModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagsFlutingModel.withError(error.toString());
    }
  }

  Future<BagsListCustomerCodeWiseModel>
      getBagsListCustomerCodeWiseData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {"UserCode": "${prefs.getString(kUserCode)}"};

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagsListCustomerCodeWise',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagsListCustomerCodeWiseModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagsListCustomerCodeWiseModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagsListCustomerCodeWiseModel.withError(
              kServiceUnavailableError);
        } else {
          return BagsListCustomerCodeWiseModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagsListCustomerCodeWiseModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagsListCustomerCodeWiseModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagsListCustomerCodeWiseModel.withError(error.toString());
    }
  }

  Future<BagsListCustomerCodeModel> getBagsListCustomerCodeData(
      int tabId, String custCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map data = {
        "UserCode": "${prefs.getString(kUserCode)}",
        "CustCode": custCode,
        "Weekly": tabId.toString()
      };

      var body = json.encode(data);

      debugPrint('request data - $body');

      Response response = await _dio.post(
        '$kBaseUrl$kBagsListbyCustomerCode',
        data: body,
      );

      debugPrint('response from generate api is - ${response.data}');
      return BagsListCustomerCodeModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.connectTimeout) {
        return BagsListCustomerCodeModel.withError(kConnectTimeOutError);
      } else if (error.type == DioErrorType.response) {
        Response? response = error.response;
        if (response != null && response.statusCode == 503) {
          return BagsListCustomerCodeModel.withError(kServiceUnavailableError);
        } else {
          return BagsListCustomerCodeModel.withError(
              response!.data[kMessage] ?? response.data.toString());
        }
      } else if (error.type == DioErrorType.receiveTimeout) {
        return BagsListCustomerCodeModel.withError(kReceiveTimeoutError);
      } else if (error.type == DioErrorType.sendTimeout) {
        return BagsListCustomerCodeModel.withError(kSendTimeoutError);
      }
      debugPrint('Data not found / Connection issue - ${error.toString()}');
      return BagsListCustomerCodeModel.withError(error.toString());
    }
  }
}
