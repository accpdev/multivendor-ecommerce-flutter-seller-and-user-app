import 'package:sixvalley_vendor_app/data/model/response/delivery_man_detail_model.dart';

class DeliveryManEarning {
  int? totalSize;
  String? limit;
  String? offset;
  double? totalEarn;
  double? withdrawableBalance;
  DeliveryMan? deliveryMan;
  List<Earning>? orders;

  DeliveryManEarning(
      {this.totalSize,
        this.limit,
        this.offset,
        this.totalEarn,
        this.withdrawableBalance,
        this.deliveryMan,
        this.orders});

  DeliveryManEarning.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if(json['total_earn'] != null){
      try{
        totalEarn = json['total_earn'].toDouble;
      }catch(e){
        totalEarn = double.parse(json['total_earn'].toString());
      }
    }

    if(json['withdrawable_balance'] != null){
      try{
        withdrawableBalance = json['withdrawable_balance'].toDouble();
      }catch(e){
        withdrawableBalance = double.parse(json['withdrawable_balance'].toString());
      }
    }


    deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
    if (json['orders'] != null) {
      orders = <Earning>[];
      json['orders'].forEach((v) {
        orders!.add(Earning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    data['total_earn'] = totalEarn;
    data['withdrawable_balance'] = withdrawableBalance;
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan!.toJson();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Earning {
  int? id;
  double? deliverymanCharge;
  String? orderStatus;
  int? deliveryManId;
  String? updatedAt;

  Earning(
      {this.id,
        this.deliverymanCharge,
        this.orderStatus,
        this.deliveryManId,
        this.updatedAt});

  Earning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['deliveryman_charge'] != null){
      try{
        deliverymanCharge = json['deliveryman_charge'].toDouble();
      }catch(e){
        deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
      }

    }

    orderStatus = json['order_status'];
    deliveryManId = int.parse(json['delivery_man_id'].toString());
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deliveryman_charge'] = deliverymanCharge;
    data['order_status'] = orderStatus;
    data['delivery_man_id'] = deliveryManId;
    data['updated_at'] = updatedAt;
    return data;
  }
}
