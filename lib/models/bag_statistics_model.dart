class BagStatisticsModel {
  List<Data>? data;

  BagStatisticsModel({this.data});
  String? error;

  BagStatisticsModel.withError(String errorMessage) {
    error = errorMessage;
  }

  BagStatisticsModel.fromJson(Map<String, dynamic> json) {
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
  String? process;
  int? processID;
  int? pCount;

  Data({this.process, this.processID, this.pCount});

  Data.fromJson(Map<String, dynamic> json) {
    process = json['Process'];
    processID = json['ProcessID'];
    pCount = json['PCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Process'] = process;
    data['ProcessID'] = processID;
    data['PCount'] = pCount;
    return data;
  }
}