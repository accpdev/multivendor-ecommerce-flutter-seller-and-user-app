import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';

class DeliveryManOrderHistory {
  int? totalSize;
  String? limit;
  String? offset;
  List<Order>? orders;

  DeliveryManOrderHistory(
      {this.totalSize, this.limit, this.offset, this.orders});

  DeliveryManOrderHistory.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


