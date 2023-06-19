class YearModel {
  int? id;
  String? year;

  YearModel({this.id, this.year});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['month'] = year;
    return data;
  }
}