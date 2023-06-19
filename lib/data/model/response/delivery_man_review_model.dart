class DeliveryManReviewModel {
  int? totalSize;
  String? limit;
  String? offset;
  String? averageRating;
  List<DeliveryManReview>? reviews;

  DeliveryManReviewModel(
      {this.totalSize,
        this.limit,
        this.offset,
        this.averageRating,
        this.reviews});

  DeliveryManReviewModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    averageRating = json['average_rating'];
    if (json['reviews'] != null) {
      reviews = <DeliveryManReview>[];
      json['reviews'].forEach((v) {
        reviews!.add(DeliveryManReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    data['average_rating'] = averageRating;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryManReview {
  int? id;
  int? productId;
  int? customerId;
  int? deliveryManId;
  int? orderId;
  String? comment;
  double? rating;
  int? status;
  int? isSaved;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  DeliveryManReview(
      {this.id,
        this.productId,
        this.customerId,
        this.deliveryManId,
        this.orderId,
        this.comment,
        this.rating,
        this.status,
        this.isSaved,
        this.createdAt,
        this.updatedAt,
        this.customer
      });

  DeliveryManReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    deliveryManId = json['delivery_man_id'];
    orderId = json['order_id'];
    comment = json['comment'];
    if(json['rating'] != null){
      try{
        rating = json['rating'].toDouble();
      }catch(e){
        rating = double.parse(json['rating'].toString());
      }
    }else{
      rating = 0;
    }

    status = json['status'];
    isSaved = json['is_saved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    data['is_saved'] = isSaved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {

  String? fName;
  String? lName;
  String? image;


  Customer(
      {
        this.fName,
        this.lName,
        this.image,
       });

  Customer.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['f_name'] = fName;
    data['l_name'] = lName;
    data['image'] = image;
    return data;
  }
}
