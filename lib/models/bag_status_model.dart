class BagStatusModel {
  List<Data>? data;

  BagStatusModel({this.data});

  String? error;

  BagStatusModel.withError(String errorMessage) {
    error = errorMessage;
  }

  BagStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? step;
  String? date;
  String? time;
  int? orderNo;

  Data({this.step, this.date, this.time, this.orderNo});

  Data.fromJson(Map<String, dynamic> json) {
    step = json['Step'];
    date = json['Date'];
    time = json['Time'];
    orderNo = json['OrderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Step'] = step;
    data['Date'] = date;
    data['Time'] = time;
    data['OrderNo'] = orderNo;
    return data;
  }
}