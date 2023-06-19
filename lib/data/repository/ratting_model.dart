import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class RattingModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Reviews>? reviews;

  RattingModel({this.totalSize, this.limit, this.offset, this.reviews});

  RattingModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? productId;
  int? customerId;
  String? comment;
  List<String>? attachment;
  double? rating;
  int? status;
  int? isSaved;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Customer? customer;

  Reviews(
      {this.id,
        this.productId,
        this.customerId,
        this.comment,
        this.attachment,
        this.rating,
        this.status,
        this.isSaved,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.customer});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    attachment = json['attachment'].cast<String>();
    rating = json['rating'].toDouble();
    status = json['status'];
    isSaved = int.parse(json['is_saved'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['comment'] = comment;
    data['attachment'] = attachment;
    data['rating'] = rating;
    data['status'] = status;
    data['is_saved'] = isSaved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

