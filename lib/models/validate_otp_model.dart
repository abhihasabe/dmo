class ValidateOTPModel {
  List<Data>? data;
  List<Details>? details;

  ValidateOTPModel({this.data, this.details});

  String? error;

  ValidateOTPModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ValidateOTPModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (details != null) {
      data['Details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? message;
  int? status;

  Data({this.message, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Status'] = status;
    return data;
  }
}

class Details {
  int? userCode;
  String? userName;
  String? fullName;
  int? empCode;
  int? sessionCode;
  String? token;

  Details(
      {this.userCode,
      this.userName,
      this.fullName,
      this.empCode,
      this.sessionCode,
      this.token});

  Details.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    userName = json['UserName'];
    fullName = json['FullName'];
    empCode = json['EmpCode'];
    sessionCode = json['SessionCode'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserCode'] = userCode;
    data['UserName'] = userName;
    data['FullName'] = fullName;
    data['EmpCode'] = empCode;
    data['SessionCode'] = sessionCode;
    data['Token'] = token;
    return data;
  }
}
