class BusinessModel {
  int? _id;
  String? _title;
  String? _duration;
  int? _cost;

  BusinessModel(
      {int? id, String? title, String? duration, int? cost}) {
    _id = id;
    _title = title;
    _duration = duration;
    _cost = cost;
  }

  int? get id => _id;
  String? get title => _title;
  String? get duration => _duration;
  int? get cost => _cost;

  BusinessModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _duration = json['duration'];
    _cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['duration'] = _duration;
    data['cost'] = _cost;
    return data;
  }
}
