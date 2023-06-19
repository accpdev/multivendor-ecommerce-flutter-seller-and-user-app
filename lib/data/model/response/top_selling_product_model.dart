import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';

class TopSellingProductModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Products>? products;

  TopSellingProductModel(
      {this.totalSize, this.limit, this.offset, this.products});

  TopSellingProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productId;
  String? count;
  Product? product;

  Products({this.productId, this.count, this.product});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['count'] = count;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}


