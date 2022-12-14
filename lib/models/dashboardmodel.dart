class DashboardModel {
  List<Data>? data;

  DashboardModel({this.data});
  String? error;

  DashboardModel.withError(String errorMessage) {
    error = errorMessage;
  }

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  int? orderNo;
  int? iD;
  String? key;
  int? val;

  Data({this.orderNo, this.iD, this.key, this.val});

  Data.fromJson(Map<String, dynamic> json) {
    orderNo = json['OrderNo'];
    iD = json['ID'];
    key = json['Key'];
    val = json['Val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderNo'] = orderNo;
    data['ID'] = iD;
    data['Key'] = key;
    data['Val'] = val;
    return data;
  }
}