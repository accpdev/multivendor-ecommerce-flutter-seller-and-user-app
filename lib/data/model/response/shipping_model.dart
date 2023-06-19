class ShippingModel {
  int? id;
  String? title;
  String? duration;
  double? cost;
  int? status;

  ShippingModel({this.id, this.title, this.duration, this.cost, this.status});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    cost = json['cost'].toDouble();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['duration'] = duration;
    data['cost'] = cost;
    data['status'] = status;
    return data;
  }
}
