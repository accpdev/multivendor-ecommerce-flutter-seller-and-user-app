class MonthModel {
  int? id;
  String? month;

  MonthModel({this.id, this.month});

  MonthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['month'] = month;
    return data;
  }
}