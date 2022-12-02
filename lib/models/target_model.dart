class TargetModel {
  List<Data>? data;

  TargetModel({this.data});

  String? error;

  TargetModel.withError(String errorMessage) {
    error = errorMessage;
  }

  TargetModel.fromJson(Map<String, dynamic> json) {
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
  String? bagNo;
  String? orderNo;
  int? pcs;
  double? carats;

  Data({this.bagNo, this.orderNo, this.pcs, this.carats});

  Data.fromJson(Map<String, dynamic> json) {
    bagNo = json['BagNo'];
    orderNo = json['OrderNo'];
    pcs = json['Pcs'];
    carats = json['Carats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BagNo'] = bagNo;
    data['OrderNo'] = orderNo;
    data['Pcs'] = pcs;
    data['Carats'] = carats;
    return data;
  }
}
