class AuthenticateModel {
  List<Data>? data;

  AuthenticateModel({this.data});

  String? error;

  AuthenticateModel.withError(String errorMessage) {
    error = errorMessage;
  }

  AuthenticateModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userCode;
  String? message;
  int? status;
  String? oTPMessage;
  int? sendMessage;
  String? mobileNumber;
  String? userType;

  Data(
      {this.userCode,
      this.message,
      this.status,
      this.oTPMessage,
      this.sendMessage,
      this.mobileNumber,
      this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    message = json['Message'];
    status = json['Status'];
    oTPMessage = json['OTPMessage'];
    sendMessage = json['SendMessage'];
    mobileNumber = json['MobileNumber'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserCode'] = userCode;
    data['Message'] = message;
    data['Status'] = status;
    data['OTPMessage'] = oTPMessage;
    data['SendMessage'] = sendMessage;
    data['MobileNumber'] = mobileNumber;
    data['UserType'] = userType;
    return data;
  }
}
