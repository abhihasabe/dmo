class DashboardModel {
  DashboardModel({
    required this.Data,
  });
  late final List<DashBoardRealData> Data;
  String? error;

  DashboardModel.withError(String errorMessage) {
    error = errorMessage;
  }

  DashboardModel.fromJson(Map<String, dynamic> json) {
    Data = List.from(json['Data'])
        .map((e) => DashBoardRealData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Data'] = Data.map((e) => e.toJson()).toList();
    return data;
  }
}

class DashBoardRealData {
  DashBoardRealData({
    required this.OrderNo,
    required this.ID,
    required this.Key,
    required this.Val,
  });
  late final int OrderNo;
  late final int ID;
  late final String Key;
  late final int Val;

  DashBoardRealData.fromJson(Map<String, dynamic> json) {
    OrderNo = json['OrderNo'];
    ID = json['ID'];
    Key = json['Key'];
    Val = json['Val'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['OrderNo'] = OrderNo;
    data['ID'] = ID;
    data['Key'] = Key;
    data['Val'] = Val;
    return data;
  }
}
