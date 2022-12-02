class BagDetailModel {
  List<Data>? data;

  BagDetailModel({this.data});
  String? error;

  BagDetailModel.withError(String errorMessage) {
    error = errorMessage;
  }

  BagDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? qualityName;
  String? shapeName;
  double? stoneSize;
  String? orderDate;
  String? expDelDate;
  int? pcs;
  double? carats;
  String? actualDelDate;

  Data(
      {this.bagNo,
        this.qualityName,
        this.shapeName,
        this.stoneSize,
        this.orderDate,
        this.expDelDate,
        this.pcs,
        this.carats,
        this.actualDelDate});

  Data.fromJson(Map<String, dynamic> json) {
    bagNo = json['BagNo'];
    qualityName = json['QualityName'];
    shapeName = json['ShapeName'];
    stoneSize = json['StoneSize'];
    orderDate = json['OrderDate'];
    expDelDate = json['ExpDelDate'];
    pcs = json['Pcs'];
    carats = json['Carats'];
    actualDelDate = json['ActualDelDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BagNo'] = bagNo;
    data['QualityName'] = qualityName;
    data['ShapeName'] = shapeName;
    data['StoneSize'] = stoneSize;
    data['OrderDate'] = orderDate;
    data['ExpDelDate'] = expDelDate;
    data['Pcs'] = pcs;
    data['Carats'] = carats;
    data['ActualDelDate'] = actualDelDate;
    return data;
  }
}