class BagsListCustomerCodeWiseModel {
  List<Data>? data;

  BagsListCustomerCodeWiseModel({this.data});

  String? error;

  BagsListCustomerCodeWiseModel.withError(String errorMessage) {
    error = errorMessage;
  }

  BagsListCustomerCodeWiseModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? custShortCode;
  int? custCode;
  int? orderCount;
  int? pcs;
  double? carats;
  int? totalBags;

  Data(
      {this.custShortCode,
      this.custCode,
      this.orderCount,
      this.pcs,
      this.carats,
      this.totalBags});

  Data.fromJson(Map<String, dynamic> json) {
    custShortCode = json['CustShortCode'];
    custCode = json['CustCode'];
    orderCount = json['OrderCount'];
    pcs = json['Pcs'];
    carats = json['Carats'];
    totalBags = json['TotalBags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CustShortCode'] = this.custShortCode;
    data['CustCode'] = this.custCode;
    data['OrderCount'] = this.orderCount;
    data['Pcs'] = this.pcs;
    data['Carats'] = this.carats;
    data['TotalBags'] = this.totalBags;
    return data;
  }
}
