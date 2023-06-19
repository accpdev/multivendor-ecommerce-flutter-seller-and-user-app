import 'dart:convert';

class ReviewModel {
  int? id;
  int? productId;
  int? customerId;
  String? comment;
  List<String>? attachment;
  double? rating;
  int? status;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Customer? customer;


  ReviewModel(
      {this.id,
        this.productId,
        this.customerId,
        this.comment,
        this.attachment,
        this.rating,
        this.status,
        this.createdAt,
        this.updatedAt,
      this.customer});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    if(json['attachment'] != null){
      try{
        attachment = json['attachment'].cast<String>();
      }catch(e){
        attachment = jsonDecode(json['attachment']).cast<String>();
      }

    }

    rating = json['rating'].toDouble();
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    customer = json['customer'] != null ?  Customer.fromJson(json['customer']) : null;


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

class Product {
  int? id;
  String? name;
  String? thumbnail;
  String? productType;
  Product(
      {this.id,
        this.name,
        this.thumbnail,
        this.productType
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['product_type'] = productType;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? fName;
  String? lName;
  String? image;



  Customer(
      {this.id,
        this.name,
        this.fName,
        this.lName,
        this.image
       });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['image'] = image;
    return data;
  }
}